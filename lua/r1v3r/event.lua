-- ================ Debug ================
local function GetAutocmdsForEvent(event_name)
	-- 使用 pcall 来安全地调用 API，并捕获可能的错误
	local status, autocmds = pcall(vim.api.nvim_get_autocmds, { event = event_name })
	if status then
		-- 如果调用成功，打印相关的自动命令
		print(vim.inspect(autocmds))
	else
		-- 如果发生错误，打印错误消息
		print("Error retrieving autocmds for event: " .. event_name)
	end
end
vim.api.nvim_create_user_command(
	"GetAutocmdsForEvent",
	GetAutocmdsForEvent,
	{ nargs = 1, desc = "check autocmds for event" }
)

local function GetAutocmdsForGroup(group_name)
	local status, autocmds =
		pcall(vim.api.nvim_get_autocmds, { group = vim.api.nvim_create_augroup(group_name, { clear = false }) })
	if status then
		print(vim.inspect(autocmds))
	else
		print("Error retrieving autocmds for group: " .. group_name)
	end
end
vim.api.nvim_create_user_command(
	"GetAutocmdsForGroup",
	GetAutocmdsForGroup,
	{ nargs = 1, desc = "check autocmds for group" }
)

-- ================ Autocmd ================
local autocmd = {}

function autocmd.cmd(cmds)
	for k, v in pairs(cmds) do
		if type(k) ~= "number" then
			vim.api.nvim_create_autocmd(k, v)
		else
			autocmd.cmd(v)
		end
	end
end

function autocmd.group(definitions)
	for group_name, definition in pairs(definitions) do
		vim.api.nvim_command("augroup " .. group_name)
		vim.api.nvim_command("autocmd!")
		for _, def in ipairs(definition) do
			local command = table.concat(vim.tbl_flatten({ "autocmd", def }), " ")
			vim.api.nvim_command(command)
		end
		vim.api.nvim_command("augroup END")
	end
end

function autocmd.cmd_init()
	autocmd.cmd({
		VimEnter = { -- transparent bg
			pattern = "*",
			command = "hi Normal guibg=NONE ctermbg=NONE",
		},
		BufReadPost = { -- Jump to last cursor position when opening a file
			pattern = "*",
			command = [[if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif]],
		},
		BufEnter = { -- Auto change directory to current dir
			pattern = "*",
			command = "silent! lcd %:p:h",
		},
		-- [{'TextChanged', 'InsertLeave'}] = { -- Save file on TextChanged and InsertLeave events
		--	 pattern = "<buffer>",
		--	 command = 'silent write'
		-- },
		-- TODO source $HOME/.config/nvim/file-snippets.vim
		[{ "BufRead", "BufNewFile" }] = { -- auto spell
			pattern = "*.md",
			command = "setlocal spell",
		},
		{
			BufEnter = { -- auto close NvimTree
				group = vim.api.nvim_create_augroup("NvimTreeClose", {
					clear = true,
				}),
				pattern = "NvimTree_*",
				callback = function()
					local layout = vim.api.nvim_call_function("winlayout", {})
					if
						layout[1] == "leaf"
						and vim.api.nvim_get_option_value("filetype", { buf = vim.api.nvim_win_get_buf(layout[2]) }) == "NvimTree"
						and layout[3] == nil
					then
						vim.api.nvim_command([[confirm quit]])
					end
				end,
			},
		},
		FileType = { -- auto close some filetype with <q>
			pattern = {
				"qf",
				"help",
				"man",
				"notify",
				"nofile",
				"lspinfo",
				"terminal",
				"prompt",
				"toggleterm",
				"copilot",
				"startuptime",
				"tsplayground",
				"PlenaryTestPopup",
			},
			callback = function(event)
				vim.bo[event.buf].buflisted = false
				vim.api.nvim_buf_set_keymap(event.buf, "n", "q", "<CMD>close<CR>", {
					silent = true,
				})
			end,
		},
	})
end

function autocmd.group_init()
	local definitions = {
		lazy = {},
		bufs = { -- Reload vim config automatically
			{ "BufWritePost", [[$VIM_PATH/{*.vim,*.yaml,vimrc} nested source $MYVIMRC | redraw]] },
			-- Reload Vim script automatically if setlocal autoread
			{
				"BufWritePost,FileWritePost",
				"*.vim",
				[[nested if &l:autoread > 0 | source <afile> | echo 'source ' . bufname('%') | endif]],
			},
			{ "BufWritePre", "/tmp/*", "setlocal noundofile" },
			{ "BufWritePre", "COMMIT_EDITMSG", "setlocal noundofile" },
			{ "BufWritePre", "MERGE_MSG", "setlocal noundofile" },
			{ "BufWritePre", "*.tmp", "setlocal noundofile" },
			{ "BufWritePre", "*.bak", "setlocal noundofile" }, -- auto place to last edit
			{ "BufReadPost", "*", [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g'\"" | endif]] }, -- Auto toggle fcitx5
			-- {"InsertLeave", "* :silent", "!fcitx5-remote -c"},
			-- {"BufCreate", "*", ":silent !fcitx5-remote -c"},
			-- {"BufEnter", "*", ":silent !fcitx5-remote -c "},
			-- {"BufLeave", "*", ":silent !fcitx5-remote -c "}
		},
		wins = { -- Highlight current line only on focused window
			{
				"WinEnter,BufEnter,InsertLeave",
				"*",
				[[if ! &cursorline && &filetype !~# '^\(dashboard\|clap_\)' && ! &pvw | setlocal cursorline | endif]],
			},
			{
				"WinLeave,BufLeave,InsertEnter",
				"*",
				[[if &cursorline && &filetype !~# '^\(dashboard\|clap_\)' && ! &pvw | setlocal nocursorline | endif]],
			},
			-- Attempt to write shada when leaving nvim
			{ "VimLeave", "*", [[if has('nvim') | wshada | else | wviminfo! | endif]] },
			-- Check if file changed when its window is focus, more eager than 'autoread'
			{ "FocusGained", "* checktime" }, -- Equalize window dimensions when resizing vim window
			{ "VimResized", "*", [[tabdo wincmd =]] },
		},
		ft = {
			{ "FileType", "alpha", "set showtabline=0" },
			{ "FileType", "markdown", "set wrap" },
			{ "FileType", "make", "set noexpandtab shiftwidth=8 softtabstop=0" },
			{ "FileType", "dap-repl", "lua require('dap.ext.autocompl').attach()" },
			{ "FileType", "*", [[setlocal formatoptions-=cro]] },
			{ "FileType", "c,cpp", "nnoremap <leader>h :ClangdSwitchSourceHeaderVSplit<CR>" },
		},
		yank = { { "TextYankPost", "*", [[silent! lua vim.highlight.on_yank({higroup="IncSearch", timeout=300})]] } },
	}

	autocmd.group(definitions)
end

function autocmd.init()
	autocmd.cmd_init()
	autocmd.group_init()
end

autocmd.init()

-- ================ LSP ================
-- defer setting LSP-related keymaps till LspAttach
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("LspKeymapLoader", { clear = true }),
	callback = function(event)
		if not _G._debugging then
			require("r1v3r.keymaps").lsp(event.buf)
		end
	end,
})

-- ================ FloatTerm ================
vim.api.nvim_create_user_command("FloatTerm", require("helper").float_terminal, {
	nargs = "*",
})
