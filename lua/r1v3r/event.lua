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
		local group_id = vim.api.nvim_create_augroup(group_name, { clear = true })

		for _, def in ipairs(definition) do
			local event, pattern, action = def[1], def[2], def[3]
			local opts = def[4] or {} -- 可选的额外选项

			if action and action ~= "" then
				local autocmd_opts = {
					group = group_id,
					pattern = pattern,
				}

				-- combine opts into autocmd_opts
				for k, v in pairs(opts) do
					autocmd_opts[k] = v
				end

				-- check if action is a function or a string
				if type(action) == "function" then
					autocmd_opts.callback = action
				else
					autocmd_opts.command = action
				end

				vim.api.nvim_create_autocmd(event, autocmd_opts)
			end
		end
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
			callback = function(event)
				-- Skip special buffers (quickfix, terminal, commit messages, ...)
				if vim.bo[event.buf].buftype ~= "" or vim.bo[event.buf].filetype == "gitcommit" then
					return
				end
				local mark = vim.api.nvim_buf_get_mark(event.buf, '"')
				local line_count = vim.api.nvim_buf_line_count(event.buf)
				if mark[1] > 1 and mark[1] <= line_count then
					vim.api.nvim_win_set_cursor(0, mark)
				end
			end,
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
					local layout = vim.fn.winlayout()
					if
						layout[1] == "leaf"
						and vim.api.nvim_get_option_value("filetype", { buf = vim.api.nvim_win_get_buf(layout[2]) }) == "NvimTree"
						and layout[3] == nil
					then
						vim.cmd("confirm quit")
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
				"copilot",
				"startuptime",
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
		bufs = {
			-- Reload Vim script automatically if setlocal autoread
			{
				{ "BufWritePost", "FileWritePost" },
				"*.vim",
				[[nested if &l:autoread > 0 | source <afile> | echo 'source ' . bufname('%') | endif]],
			},
			{ "BufWritePre", "/tmp/*", "setlocal noundofile" },
			{ "BufWritePre", "COMMIT_EDITMSG", "setlocal noundofile" },
			{ "BufWritePre", "MERGE_MSG", "setlocal noundofile" },
			{ "BufWritePre", "*.tmp", "setlocal noundofile" },
			{ "BufWritePre", "*.bak", "setlocal noundofile" },
			-- {"InsertLeave", "* :silent", "!fcitx5-remote -c"},
			-- {"BufCreate", "*", ":silent !fcitx5-remote -c"},
			-- {"BufEnter", "*", ":silent !fcitx5-remote -c "},
			-- {"BufLeave", "*", ":silent !fcitx5-remote -c "}
		},
		wins = { -- Highlight current line only on focused window
			{
				{ "WinEnter", "BufEnter", "InsertLeave" },
				"*",
				[[if ! &cursorline && &filetype !=# 'alpha' && ! &pvw | setlocal cursorline | endif]],
			},
			{
				{ "WinLeave", "BufLeave", "InsertEnter" },
				"*",
				[[if &cursorline && &filetype !=# 'alpha' && ! &pvw | setlocal nocursorline | endif]],
			},
			-- Check if files changed when Neovim regains focus, more eager than 'autoread'.
			{ "FocusGained", "*", "checktime" },
			-- Equalize window dimensions when resizing the UI.
			{ "VimResized", "*", [[tabdo wincmd =]] },
		},
		ft = {
			{ "FileType", "alpha", "set showtabline=0" },
			{ "FileType", "markdown", "set wrap" },
			{ "FileType", "make", "set noexpandtab shiftwidth=8 softtabstop=0" },
			{ "FileType", "dap-repl", "lua require('dap.ext.autocompl').attach()" },
			{ "FileType", "*", [[setlocal formatoptions-=cro]] },
			{ "FileType", "c,cpp", "nnoremap <leader>h :ClangdSwitchSourceHeaderVSplit<CR>" },
			{
				"FileType",
				{ "lazy", "mason" },
				function()
					vim.keymap.set("n", "<up>", "<up>", { buffer = true, silent = true })
					vim.keymap.set("n", "<down>", "<down>", { buffer = true, silent = true })
					vim.keymap.set("n", "<left>", "<left>", { buffer = true, silent = true })
					vim.keymap.set("n", "<right>", "<right>", { buffer = true, silent = true })
				end,
			},
		},
		yank = {
			{
				"TextYankPost",
				"*",
				function()
					vim.hl.on_yank({ higroup = "IncSearch", timeout = 300 })
				end,
			},
		},
	}

	autocmd.group(definitions)
end

function autocmd.init()
	autocmd.cmd_init()
	autocmd.group_init()
end

autocmd.init()

-- ================ LSP ================
-- bootstrap the native LSP setup (vim.lsp.config/enable + diagnostics) on the
-- first real buffer, see `plugins/configs/completion/lsp.lua`
vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
	group = vim.api.nvim_create_augroup("LspBootstrap", { clear = true }),
	once = true,
	callback = function()
		require("completion.lsp")()
	end,
})

-- defer setting LSP-related keymaps till LspAttach
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("LspKeymapLoader", { clear = true }),
	callback = function(event)
		require("r1v3r.keymaps").lsp(event.buf)
	end,
})

-- ================ FloatTerm ================
vim.api.nvim_create_user_command("FloatTerm", require("helper").float_terminal, {
	nargs = "*",
})
