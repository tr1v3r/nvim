require("helper.plugins")
local map = require("helper.mapping").map

-- =============== Basic Key Mapping ================
-- Leader key
vim.g.mapleader = " "

local setGeneralKeys = function()
	-- map("s", "<nop>"):noremap():set()

	-- Undo
	map("l", "u"):noremap():set()

	-- Insert Key
	map("k", "i"):noremap():set()
	map("K", "I"):noremap():set()

	-- Find pair
	map(",.", "%"):noremap():set()

	-- Search
	map("<ESC>", _flash_esc_or_noh):mode("n"):noremap():desc("edit: clear highlight"):set()

	-- Adjacent duplicate words
	map("<LEADER>dw", [[/\(\<\w\+\>\)\_s*\1]]):noremap():desc("edit: find adjacent duplicate words"):set()

	-- Find and replace
	map([[\s]], ":%s//g<left><left>"):noremap():desc("edit: find and replace string in current file"):set()
	map([[\s]], ":s//g<left><left>"):mode("v"):noremap():desc("edit: find and replace string in current file"):set()
	map([[\S]], [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
		:mode("n")
		:noremap()
		:desc("edit: find and replace all current word")
		:set()

	-- Find and delete (line)
	map([[\d]], ":g//d<left><left>"):noremap():desc("edit: find and delete"):set()

	-- Copy to system clipboard
	-- map("Y", [["+y]]):mode("v"):noremap():silent():desc("edit: copy to system clipboard"):set()

	-- Space to Tab
	map("<LEADER>tt", [[:%s/    /\t/g]]):mode("n"):noremap():desc("edit: replace space to tab"):set()
	map("<LEADER>tt", [[:s/    /\t/g]]):mode("v"):noremap():desc("edit: replace space to tab"):set()

	-- Folding
	map("<LEADER>o", "za"):noremap():desc("edit: folding"):set()

	-- Move cursor in find results
	map("=", "nzz"):noremap():set()
	map("-", "Nzz"):noremap():set()

	map("<LEADER>R", "e!"):mode("n"):noremap():cmd():desc("edit: reload current file"):set()

	-- Quit key
	map("S", "w"):mode("n"):cmd():noremap():desc("edit: save file"):set()
	map("Q", "quitall"):mode("n"):cmd():noremap():desc("edit: quit all files"):set()

	map(";", ":"):noremap():desc("edit: key replace"):set()
	map("`", "~"):noremap():desc("edit: key replace"):set()

	-- ==================== Cursor Movement ====================
	-- New cursor movement (the default arrow keys are used for resizing windows)
	--     ^
	--     u
	-- < n   i >
	--     e
	--     v
	map("n", "h"):noremap():set()
	map("e", "j"):noremap():set()
	map("u", "k"):noremap():set()
	map("i", "l"):noremap():set()
	map("gu", "gk"):noremap():set()
	map("ge", "gj"):noremap():set()
	map("h", "e"):noremap():set()

	map([[\v]], "v$h"):noremap():desc("edit: select content from cursor to line end"):set()

	-- scroll
	map("U", "12k"):noremap():set()
	map("E", "12j"):noremap():set()
	-- map("U", ":m '<-2<CR>gv=gv"):noremap():set() -- move selected block move up
	-- map("E", ":m '>+1<CR>gv=gv"):noremap():set() -- move selected block move down
	-- go to start/end of the line
	map("N", "0"):noremap():set()
	map("I", "$"):noremap():set()
	-- fast move
	map("W", "5w"):noremap():set()
	map("B", "5b"):noremap():set()
	-- move up/down the view port without moving the cursor
	map("<C-U>", "5<C-y>"):noremap():set()
	map("<C-E>", "5<C-e>"):noremap():set()

	-- Custom cursor movement
	-- source $HOME/.config/nvim/cursor.vim

	-- ==================== Copy/Paste ====================
	map("<LEADER>p", [["_dP]]):mode("x"):noremap():desc("edit: replace block without change clipboard"):set()

	-- ==================== Insert Mode Cursor Movement ====================
	map("<C-a>", "<ESC>A"):mode("i"):noremap():set()

	-- ==================== Command Mode Cursor Movement ====================
	map("<C-a>", "<Home>"):mode("c"):noremap():set()
	map("<C-e>", "<End>"):mode("c"):noremap():set()
	map("<C-p>", "<Up>"):mode("c"):noremap():set()
	map("<C-n>", "<Down>"):mode("c"):noremap():set()
	map("<C-b>", "<Left>"):mode("c"):noremap():set()
	map("<C-f>", "<Right>"):mode("c"):noremap():set()
	map("<M-b>", "<S-Left>"):mode("c"):noremap():set()
	map("<M-w>", "<S-Right>"):mode("c"):noremap():set()

	-- ==================== Window management ====================
	-- map("<LEADER>w", "<C-w>w"):noremap():set()
	map("<LEADER>u", "<C-w>k"):noremap():set()
	map("<LEADER>e", "<C-w>j"):noremap():set()
	map("<LEADER>n", "<C-w>h"):noremap():set()
	map("<LEADER>i", "<C-w>l"):noremap():set()

	map("tq", "<C-w>o"):noremap():desc("window: close or other windows"):set()

	-- Split the screens to up/down/left/right
	map("su", "set nosplitbelow<CR><Cmd>split<CR><Cmd>set splitbelow")
		:mode("n")
		:cmd()
		:noremap()
		:desc("window: split up")
		:set()
	map("se", "set splitbelow<CR><Cmd>split"):mode("n"):cmd():noremap():desc("window: split down"):set()
	map("sn", "set nosplitright<CR><Cmd>vsplit<CR><Cmd>set splitright")
		:mode("n")
		:cmd()
		:noremap()
		:desc("windown: split left")
		:set()
	map("si", "set splitright<CR><Cmd>vsplit"):mode("n"):cmd():noremap():desc("window: split right"):set()

	-- Resize window
	map("<up>", "res +5"):noremap():cmd():desc("window: expand window size"):set()
	map("<down>", "res -5"):noremap():cmd():desc("window: shorten window size"):set()
	map("<left>", "vertical resize-5"):noremap():cmd():desc("window: vertical expand window size"):set()
	map("<right>", "vertical resize+5>"):noremap():cmd():desc("window: vertical shorten window size"):set()

	map("sh", "<C-w>t<C-w>K"):mode("n"):noremap():desc("window: place the two windows up and down"):set()
	map("sv", "<C-w>t<C-w>H"):mode("n"):noremap():desc("window: Place the two windows side by side"):set()
	map("srh", "<C-w>b<C-w>K"):mode("n"):noremap():desc("window: rotate windows"):set()
	map("srv", "<C-w>b<C-w>H"):mode("n"):noremap():desc("window: rotate windows"):set()

	map("<LEADER>q", "<C-w>j<Cmd>q<CR>"):noremap():desc("window: close current window"):set()

	-- Opening a terminal window
	local newTermCmd = "<Cmd>term<CR><Cmd>set filetype=terminal<CR><Cmd>set norelativenumber<CR><Cmd>set nonumber<CR>"
	map("<LEADER>/", "<Cmd>set splitbelow<CR><Cmd>split<CR><Cmd>res -5<CR>" .. newTermCmd .. "i")
		:noremap()
		:desc("window: open terminal window")
		:set()
	map("<C-`>", "<Cmd>set splitbelow<CR><Cmd>split<CR><Cmd>res -5<CR>" .. newTermCmd .. "i")
		:noremap()
		:desc("window: open terminal window")
		:set()
	map("<C-\\>", "<Cmd>set nosplitbelow<CR><Cmd>vsplit<CR><Cmd>vertical resize-30<CR>" .. newTermCmd .. "i")
		:noremap()
		:desc("window: open terminal window")
		:set()
	-- Open a new instance of st with the cwd
	-- nnoremap \t :tabe<CR>:-tabmove<CR>:term sh -c 'st'<CR><C-\><C-N>:q<CR>
	-- Open a new terminal tab
	map([[\t]], "<Cmd>tabe<CR><Cmd>term<CR>i"):noremap():desc("window: open terminal window in new tab"):set()
	map("<Esc><Esc>", [[<C-\><C-n>]]):mode("t"):noremap():desc("edit: switch to normal mode"):set() -- switch to normal mode in terminal.
	-- map("jk", [[<C-\><C-n>]]):mode("t"):noremap():set() -- switch to normal mode in terminal.

	-- ==================== Tab management ====================
	-- Create a new tab with tu
	map("tu", "tabe"):noremap():cmd():desc("tab: new tab"):set()
	map("tU", "tab split"):noremap():cmd():desc("tab: new tab and switch"):set()
	-- Move around tabs with tn and ti
	map("tn", "-tabnext"):noremap():cmd():desc("tab: move to left tab"):set()
	map("ti", "+tabnext"):noremap():cmd():desc("tab: move to right tab"):set()
	-- Move the tabs with tN and tI
	map("tN", "-tabmove"):noremap():cmd():desc("tab: move tab to left"):set()
	map("tI", "+tabmove"):noremap():cmd():desc("tab: move tab to right"):set()

	-- Tab switch
	map("", ":nn <Leader>1 1gt"):exec()
	map("", ":nn <Leader>2 2gt"):exec()
	map("", ":nn <Leader>3 3gt"):exec()
	map("", ":nn <Leader>4 4gt"):exec()
	map("", ":nn <Leader>5 5gt"):exec()
	map("", ":nn <Leader>6 6gt"):exec()
	map("", ":nn <Leader>7 7gt"):exec()
	map("", ":nn <Leader>8 8gt"):exec()
	map("", ":nn <Leader>9 9gt"):exec()
	map("", ":nn <Leader>0 <Cmd>tablast<CR>"):exec()

	map("tw", "tabclose"):noremap():cmd():desc("tab: close current tab"):set()
	map("to", "tabonly"):noremap():cmd():desc("tab: close all other tabs"):set()

	-- ==================== Other useful stuff ====================
	map("<LEADER><LEADER>", "<Esc>/<++><CR><Cmd>nohlsearch<CR>c4l")
		:noremap()
		:silent()
		:desc("edit: jump to the next '<++>' and edit it")
		:set()

	-- Spelling Check with <space>sc
	map("<LEADER>sc", "set spell!"):noremap():cmd():desc("edit: spelling check"):set()

	-- adjust current line to center of screen
	map("<C-c>", "zz"):noremap():desc("edit: adjust current line to center of screen"):set()

	-- Set wrap
	map("<LEADER>sw", "set wrap"):noremap():cmd():desc("edit: set wrap"):set()

	-- Call figlet
	map("tx", "r !figlet"):space():noremap():desc("tool: call figlet"):set()
end

-- ==================== Plugins Keymaps ====================
local setLazyKeys = function()
	-- Package manager: lazy.nvim
	map("<LEADER>LL", "Lazy"):mode("n"):cmd():noremap():nowait():desc("package: Show"):set()
	map("<LEADER>Ls", "Lazy sync"):mode("n"):cmd():noremap():nowait():desc("package: Sync"):set()
	map("<LEADER>Lu", "Lazy update"):mode("n"):cmd():noremap():nowait():desc("package: Update"):set()
	map("<LEADER>Li", "Lazy install"):mode("n"):cmd():noremap():nowait():desc("package: Install"):set()
	map("<LEADER>Ll", "Lazy log"):mode("n"):cmd():noremap():nowait():desc("package: Log"):set()
	map("<LEADER>Lc", "Lazy check"):mode("n"):cmd():noremap():nowait():desc("package: Check"):set()
	map("<LEADER>Ld", "Lazy debug"):mode("n"):cmd():noremap():nowait():desc("package: Debug"):set()
	map("<LEADER>Lp", "Lazy profile"):mode("n"):cmd():noremap():nowait():desc("package: Profile"):set()
	map("<LEADER>Lr", "Lazy restore"):mode("n"):cmd():noremap():nowait():desc("package: Restore"):set()
	map("<LEADER>Lx", "Lazy clean"):mode("n"):cmd():noremap():nowait():desc("package: Clean"):set()
end

local setCompletionPlugKeys = function()
	-- map("<C-f>", "FormatToggle"):mode("n"):cmd()::noremap():desc("Formater: Toggle format on save"):set()
end

local setEditorPlugKeys = function()
	-- Plugin: accelerated-jk
	map("u", "<Plug>(accelerated_jk_gk)"):mode("n"):noremap():set()
	map("e", "<Plug>(accelerated_jk_gj)"):mode("n"):noremap():set()
	map("gu", "<Plug>(accelerated_jk_k)"):mode("n"):noremap():set()
	map("ge", "<Plug>(accelerated_jk_j)"):mode("n"):noremap():set()

	-- Plugin: persisted.nvim
	map("<LEADER>ss", "SessionSave"):mode("n"):cmd():noremap():desc("session: save"):set()
	map("<LEADER>sl", "SessionLoad"):mode("n"):cmd():noremap():desc("session: load current"):set()
	map("<LEADER>sd", "SessionDelete"):mode("n"):cmd():noremap():desc("session: delete"):set()

	-- Plugin: gcmt/wildfire.vim
	-- map("<LEADER><Tab>", "<Plug>(wildfire-quick-select)"):mode("n"):noremap():silent():desc("edit: select"):set()

	-- Plugin: comment.nvim
	map("<C-/>", "<Plug>(comment_toggle_linewise_current)<CR>")
		:mode("n")
		:noremap()
		:silent()
		:desc("edit: Toggle comment for line")
		:set()
	map("<LEADER>cc", "<Plug>(comment_toggle_blockwise_curent)")
		:mode("n")
		:noremap()
		:silent()
		:desc("edit: Toggle comment for block")
		:set()
	map("<C-/>", "<Plug>(comment_toggle_linewise_visual)")
		:mode("x")
		:noremap()
		:silent()
		:desc("edit: Toggle comment for line with selection")
		:set()
	map("<LEADER>cc", "<Plug>(comment_toggle_blockwise_visual)")
		:mode("x")
		:noremap()
		:silent()
		:desc("edit: Toggle comment for block with selection")
		:set()
	-- map("gcc"):mode("n"):callback(function()
	--	 return vim.v.count == 0 and et("<Plug>(comment_toggle_linewise_current)") or
	--				et("<Plug>(comment_toggle_linewise_count)")
	-- end):noremap():silent():expr():desc("edit: Toggle comment for line"):set()
	-- map("gbc"):mode("n"):callback(function()
	--	 return vim.v.count == 0 and et("<Plug>(comment_toggle_blockwise_current)") or
	--				et("<Plug>(comment_toggle_blockwise_count)")
	-- end):noremap():silent():expr():desc("edit: Toggle comment for block"):set()

	-- Plugin: diffview
	map("<LEADER>DD", "DiffviewOpen"):mode("n"):cmd():noremap():desc("git: Show diff"):set()
	map("<LEADER>DW", "DiffviewClose"):mode("n"):cmd():noremap():desc("git: Close diff"):set()

	-- Plugin: vim-easy-align
	map("<LEADER>a", "EasyAlign"):mode("nx"):cmd():desc("edit: Align with delimiter"):set()

	-- Plugin: hop
	map("<LEADER>w", "HopWordMW"):mode("nv"):cmd():noremap():desc("jump: Goto word"):set()
	-- map("<LEADER>j", "HopLine"):mode("nv"):cmd()::noremap():desc("jump: Goto line"):set()
	map("<LEADER>k", "HopLineMW"):mode("nv"):cmd():noremap():desc("jump: Goto line"):set()
	-- map("<LEADER>c", "HopChar1"):mode("nv"):cmd()::noremap():desc("jump: Goto one char"):set()
	-- map("<LEADER>cc", "HopChar2"):mode("nv"):cmd()::noremap():desc("jump: Goto two chars"):set()

	-- Plugin: treehopper
	map("m", "lua require('tsht').nodes()"):mode("o"):cmd():desc("jump: Operate across syntax tree"):set()

	-- Plugin: tabout
	-- map("<C-n>", "<Plug>(TaboutBackMulti)"):mode("i"):noremap():silent():desc("edit: Goto begin of pair"):set()
	map("<C-i>", "<Plug>(TaboutMulti)"):mode("i"):noremap():desc("edit: Goto end of pair"):set()

	-- Plugin suda.vim
	map("<A-s>", "SudaWrite"):mode("n"):cmd():noremap():desc("edit: Save file using sudo"):set()
end

local setLangPlugKeys = function()
	-- Plugin MarkdownPreview
	map("<F12>", "MarkdownPreviewToggle"):mode("n"):cmd():noremap():desc("tool: Preview markdown"):set()
end

local setToolPlugKeys = function()
	-- Plugin: vim-fugitive ; using lazggit
	-- map("gps", "G push"):cmd():noremap():desc("git: Push"):set()
	-- map("gpl", "G pull"):cmd():noremap():desc("git: Pull"):set()
	-- map("<LEADER>G", "Git"):cmd():noremap():desc("git: Open git-fugitive"):set()

	-- Plugin: nvim-tree
	map("tt", "NvimTreeFindFileToggle"):mode("n"):cmd():noremap():desc("tool: Locate file in nvim-tree"):set()
	map("tr", "NvimTreeRefresh"):mode("n"):cmd():noremap():desc("tool: Refresh nvim-Tree"):set()
	-- map("tf", "NvimTreeFocus"):mode("n"):cmd():noremap():desc("tree: Focus tree"):set()

	--  Plugin: lazygit
	-- map("<C-G>", "LazyGit"):noremap():set()
	map("<C-g>", _open_lazygit) -- luacheck: ignore
		:mode("n")
		:noremap()
		:desc("tool: Toggle lazygit")
		:set()

	-- Plugin: ranger
	-- map("R", "Ranger"):mode("n"):cmd():noremap():desc("tool: Toggle ranger"):set()
	map("R", "RnvimrToggle<CR><C-\\><C-n>:RnvimrResize 2"):mode("n"):cmd():noremap():desc("tool: Toggle ranger"):set()
	map("<A-=>", "<C-\\><C-n>:RnvimrResize<CR>")
		:mode("t")
		:noremap()
		:silent()
		:desc("tool: Resize ranger float window")
		:set()

	-- Plugin: sniprun
	map("<LEADER>r", "SnipRun"):mode("v"):cmd():noremap():desc("tool: Run code by range"):set()
	map("<LEADER>r", "SnipRun"):mode("n"):cmd():noremap():desc("tool: Run code by file"):set()

	-- -- Plugin: toggleterm
	-- map("<C-\\>", 'execute v:count . "ToggleTerm direction=horizontal"'):mode("n"):noremap():silent():desc(
	--	 "terminal: Toggle horizontal"):set()
	-- map("<C-\\>", "<Esc><Cmd>ToggleTerm direction=horizontal<CR>"):mode("i"):noremap():silent():desc(
	--	 "terminal: Toggle horizontal"):set()
	-- map("<C-\\>", "<Cmd>ToggleTerm<CR>"):mode("t"):noremap():silent():desc("terminal: Toggle horizontal"):set()
	-- map("<A-\\>", [[execute v:count . "ToggleTerm direction=vertical"]]):mode("n"):cmd():noremap():silent():desc(
	--	 "terminal: Toggle vertical"):set()
	-- map("<A-\\>", "<Esc><Cmd>ToggleTerm direction=vertical<CR>"):mode("i"):noremap():silent():desc(
	--	 "terminal: Toggle vertical"):set()
	-- map("<A-\\>", "<Cmd>ToggleTerm<CR>"):mode("t"):noremap():silent():desc("terminal: Toggle vertical"):set()
	-- map("<F7>", [[execute v:count . "ToggleTerm direction=vertical"]]):mode("n"):noremap():silent():desc(
	--	 "terminal: Toggle vertical"):set()
	-- map("<F7>", "<Esc><Cmd>ToggleTerm direction=vertical<CR>"):mode("i"):noremap():silent():desc(
	--	 "terminal: Toggle vertical"):set()
	-- map("<F7>", "<Cmd>ToggleTerm<CR>"):mode("t"):noremap():silent():desc("terminal: Toggle vertical"):set()
	-- map("<A-d>", [[execute v:count . "ToggleTerm direction=float"]]):mode("n"):noremap():silent():desc(
	--	 "terminal: Toggle float"):set()
	-- map("<A-d>", "<Esc><Cmd>ToggleTerm direction=float<CR>"):mode("i"):noremap():silent():desc("terminal: Toggle float")
	--	 :set()
	-- map("<A-d>", "<Cmd>ToggleTerm<CR>"):mode("t"):noremap():silent():desc("terminal: Toggle float"):set()

	-- Plugin: trouble
	map("gt", "TroubleToggle"):mode("n"):cmd():noremap():desc("lsp: Toggle trouble list"):set()
	map("<LEADER>ta", "TroubleToggle lsp_references")
		:mode("n")
		:cmd()
		:noremap()
		:silent()
		:desc("lsp: Show lsp references")
		:set()
	map("<LEADER>td", "TroubleToggle document_diagnostics")
		:mode("n")
		:cmd()
		:noremap()
		:silent()
		:desc("lsp: Show document diagnostics")
		:set()
	map("<LEAEDR>ta", "TroubleToggle workspace_diagnostics")
		:mode("n")
		:cmd()
		:noremap()
		:silent()
		:desc("lsp: Show workspace diagnostics")
		:set()
	map("<LEADER>tq", "TroubleToggle quickfix"):mode("n"):cmd():noremap():desc("lsp: Show loclist"):set()
	map("<LEADER>tl", "TroubleToggle loclist"):mode("n"):cmd():noremap():desc("lsp: Show loclist"):set()

	-- Plugin: telescope
	map("<C-p>", _command_panel):mode("n"):noremap():desc("tool: Toggle command panel"):set()

	local extensions = function()
		return require("telescope").extensions
	end
	local undo = function()
		extensions().undo.undo()
	end
	local projects = function()
		extensions().projects.projects({})
	end
	local frecency = function()
		extensions().frecency.frecency({})
	end
	local grep = function()
		extensions().live_grep_args.live_grep_args()
	end
	local colorscheme = function()
		require("telescope.builtin").colorscheme({ enable_preview = true })
	end

	map("<LEADER>U", undo):mode("n"):noremap():desc("edit: Show undo history"):set()
	map("<LEADER>tp", projects):mode("n"):noremap():desc("find: Project"):set()
	map("<LEADER>tr", frecency):mode("n"):noremap():desc("find: File by frecency"):set()
	map("<LEADER>tw", grep):mode("n"):noremap():desc("find: Word in project"):set()
	map("<LEADER>te", "Telescope oldfiles"):mode("n"):cmd():noremap():desc("find: File by history"):set()
	map("<LEADER>tf", "Telescope find_files"):mode("n"):cmd():noremap():desc("find: File in project"):set()
	map("<LEADER>tc", colorscheme):mode("n"):noremap():desc("ui: Change colorscheme for current session"):set()
	map("<LEADER>tn", "enew"):mode("n"):cmd():noremap():desc("buffer: New"):set()
	map("<LEADER>tg", "Telescope git_files"):mode("n"):cmd():noremap():desc("find: File in git project"):set()
	map("<LEADER>tz", "Telescope zoxide list")
		:mode("n")
		:cmd()
		:noremap()
		:desc("edit: Change current direrctory by zoxide")
		:set()
	map("<LEADER>tb", "Telescope buffers"):mode("n"):cmd():noremap():desc("find: Buffer opened"):set()
	map("<LEADER>t*", "Telescope grep_string"):mode("n"):cmd():noremap():desc("find: Current word"):set()
	map("<LEADER>ts", "Telescope persisted"):mode("n"):cmd():noremap():desc("find: Session"):set()
	map("<LEADER>th", "Telescope help_tags"):mode("n"):cmd():noremap():desc("help: Show helps"):set()
	map("<LEADER>tG", "Telescope git_status"):mode("n"):cmd():noremap():desc("help: Show helps"):set()

	-- Plugin: dap & dap-go
	local lazy_call = function(module, funcName)
		return function()
			require(module)[funcName]()
		end
	end
	local dap_lazy_call = function(funcName)
		return lazy_call("dap", funcName)
	end
	local go_lazy_call = function(funcName)
		return lazy_call("dap-go", funcName)
	end

	map("<LEADER>du", go_lazy_call("debug_test")):mode("n"):noremap():desc("debug: Run Current Unit Test"):set()
	map("<LEADER>dU", go_lazy_call("debug_last_test")):mode("n"):noremap():desc("debug: Run Last Unit Test"):set()
	map("<F5>", dap_lazy_call("continue")):mode("n"):noremap():desc("debug: Run/Continue"):set()
	map("<F6>", dap_lazy_call("terminate")):mode("n"):noremap():desc("debug: Stop"):set()
	map("<F8>", dap_lazy_call("toggle_breakpoint")):mode("n"):noremap():desc("debug: Toggle breakpoint"):set()
	map("<F9>", dap_lazy_call("step_into")):mode("n"):noremap():desc("debug: Step into"):set()
	map("<F10>", dap_lazy_call("step_out")):mode("n"):noremap():desc("debug: Step out"):set()
	map("<F11>", dap_lazy_call("step_over")):mode("n"):noremap():desc("debug: Step over"):set()
	map("<LEADER>db", function()
			require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
		end)
		:mode("n")
		:noremap()
		:silent()
		:desc("debug: Set breakpoint with condition")
		:set()
	map("<LEADER>dc", dap_lazy_call("run_to_cursor")):mode("n"):noremap():desc("debug: Run to cursor"):set()
	map("<LEADER>dl", dap_lazy_call("run_last")):mode("n"):noremap():desc("debug: Run last"):set()
	map("<LEADER>do", function()
			require("dap").repl.open()
		end)
		:mode("n")
		:noremap()
		:silent()
		:desc("debug: Open REPL")
		:set()

	-- Plugin: spectre
	-- map("<LEADER>F", [[<Cmd>lua require("spectre").open()<CR>i]])
	map("<LEADER>F", 'lua require("spectre").open()')
		:cmd()
		:append("i")
		:mode("n")
		:noremap()
		:desc("tool: find and replace")
		:set()
	map("<LEADER>F", 'lua require("spectre").open_visual()')
		:cmd()
		:append("i")
		:mode("v")
		:noremap()
		:desc("tool: find and replace")
		:set()
end

local setUIPlugKeys = function()
	-- Plugin: bufferline
	-- map("<A-w>", "BufDel!"):mode("n"):cmd():noremap():desc("buffer: Close current"):set()
	-- map("<A-q>", "BufferLineCloseOthers"):mode("n"):cmd():noremap():desc("buffer: Close others"):set()
	map("<A-i>", "BufferLineCycleNext"):mode("n"):cmd():noremap():desc("buffer: Switch to next"):set()
	map("<A-n>", "BufferLineCyclePrev"):mode("n"):cmd():noremap():desc("buffer: Switch to prev"):set()
	map("<A-I>", "BufferLineMoveNext"):mode("n"):cmd():noremap():desc("buffer: Move current to next"):set()
	map("<A-N>", "BufferLineMovePrev"):mode("n"):cmd():noremap():desc("buffer: Move current to prev"):set()
	map("<LEADER>be", "BufferLineSortByExtension"):mode("n"):cmd():noremap():desc("buffer: Sort by extension"):set()
	map("<LEADER>bd", "BufferLineSortByDirectory"):mode("n"):cmd():noremap():desc("buffer: Sort by direrctory"):set()
	map("<A-1>", "BufferLineGoToBuffer 1"):mode("n"):cmd():noremap():desc("buffer: Goto buffer 1"):set()
	map("<A-2>", "BufferLineGoToBuffer 2"):mode("n"):cmd():noremap():desc("buffer: Goto buffer 2"):set()
	map("<A-3>", "BufferLineGoToBuffer 3"):mode("n"):cmd():noremap():desc("buffer: Goto buffer 3"):set()
	map("<A-4>", "BufferLineGoToBuffer 4"):mode("n"):cmd():noremap():desc("buffer: Goto buffer 4"):set()
	map("<A-5>", "BufferLineGoToBuffer 5"):mode("n"):cmd():noremap():desc("buffer: Goto buffer 5"):set()
	map("<A-6>", "BufferLineGoToBuffer 6"):mode("n"):cmd():noremap():desc("buffer: Goto buffer 6"):set()
	map("<A-7>", "BufferLineGoToBuffer 7"):mode("n"):cmd():noremap():desc("buffer: Goto buffer 7"):set()
	map("<A-8>", "BufferLineGoToBuffer 8"):mode("n"):cmd():noremap():desc("buffer: Goto buffer 8"):set()
	map("<A-9>", "BufferLineGoToBuffer 9"):mode("n"):cmd():noremap():desc("buffer: Goto buffer 9"):set()

	-- Plugin: nvim-bufdel
	map("<A-w>", "BufDel"):mode("n"):cmd():noremap():desc("buffer: Close current"):set()
	map("<A-o>", "BufDelOthers"):mode("n"):cmd():noremap():desc("buffer: Close others"):set()
end

local setNeovideKeys = function()
	-- Refer to https://neovide.dev/faq.html?highlight=paste#how-can-i-use-cmd-ccmd-v-to-copy-and-paste

	map("<D-s>", "w"):mode("n"):cmd():set() -- Save
	map("<D-c>", '"+y'):mode("v"):set() -- Copy
	map("<D-v>", '"+P'):mode("n"):set() -- Paste normal mode
	map("<D-v>", '"+P'):mode("v"):set() -- Paste visual mode
	map("<D-v>", "<C-R>+"):mode("c"):set() -- Paste command mode
	map("<D-v>", '<ESC>i"+Pik'):mode("i"):set() -- Paste insert mode

	-- Allow clipboard copy paste in neovim
	map("<D-v>", "+p<CR>"):mode(""):noremap():silent():set()
	map("<D-v>", "<C-R>+"):mode("!"):noremap():silent():set()
	map("<D-v>", "<C-R>+"):mode("t"):noremap():silent():set()
	map("<D-v>", "<C-R>+"):mode("v"):noremap():silent():set()
end

local setKeys = function()
	setGeneralKeys()

	if vim.g.vscode then
		return
	end

	if vim.g.neovide then
		setNeovideKeys()
	end

	setLazyKeys()
	setCompletionPlugKeys()
	setEditorPlugKeys()
	setLangPlugKeys()
	setToolPlugKeys()
	setUIPlugKeys()
end

setKeys()

local mapping = {}

function mapping.lsp(buf)
	-- LSP-related keymaps, work only when event = { "InsertEnter", "LspStart" }
	map("<LEADER>li", "LspInfo"):mode("n"):cmd():buffer(buf):desc("lsp: Info"):set()
	map("<LEADER>lr", "LspRestart"):mode("n"):cmd():buffer(buf):nowait():desc("lsp: Restart"):set()

	-- AerialToggle! with ! toggle aesial outline window and do not move cursor to outline window
	map("go", "AerialToggle"):mode("n"):cmd():buffer(buf):desc("lsp: Toggle outline"):set()
	map("gO", function()
			require("telescope").extensions.aerial.aerial()
		end)
		:mode("n")
		:buffer(buf)
		:desc("lsp: Toggle outline in Telescope")
		:set()

	map("g[", "Lspsaga diagnostic_jump_prev"):mode("n"):cmd():buffer(buf):desc("lsp: Prev diagnostic"):set()
	map("g]", "Lspsaga diagnostic_jump_next"):mode("n"):cmd():buffer(buf):desc("lsp: Next diagnostic"):set()
	map("<LEADER>ld", "Lspsaga show_line_diagnostics ++unfocus")
		:mode("n")
		:cmd()
		:buffer(buf)
		:desc("lsp: Line diagnostic")
		:set()
	map("gs", function()
			vim.lsp.buf.signature_help()
		end)
		:mode("n")
		:desc("lsp: Signature help")
		:set()
	-- map("<LEADER>cw", "Lspsaga rename"):mode("n"):cmd():buffer(buf):desc("lsp: Rename in file range"):set()
	map("<LEADER>cw", "Lspsaga rename ++project"):mode("n"):cmd():buffer(buf):desc("lsp: Rename in project range"):set()
	map("<LEADER>hh", "Lspsaga hover_doc"):mode("n"):cmd():buffer(buf):desc("lsp: Show doc"):set()
	map("ga", "Lspsaga code_action"):mode("nv"):cmd():buffer(buf):desc("lsp: Code action for cursor"):set()
	map("gD", "Lspsaga peek_definition"):mode("n"):cmd():buffer(buf):desc("lsp: Preview definition"):set()
	map("gd", "Glance definitions"):mode("n"):cmd():buffer(buf):desc("lsp: Goto definition"):set()
	map("gr", "Glance references"):mode("n"):cmd():buffer(buf):desc("lsp: Show reference"):set()
	map("<LEADER>ci", "Lspsaga incoming_calls"):mode("n"):cmd():buffer(buf):desc("lsp: Show incoming calls"):set()
	map("<LEADER>co", "Lspsaga outgoing_calls"):mode("n"):cmd():buffer(buf):desc("lsp: Show outgoing calls"):set()
end

function mapping.gitsigns(buf)
	local actions = require("gitsigns.actions")
	map("]g", function()
			if vim.wo.diff then
				return "]g"
			end
			vim.schedule(function()
				actions.next_hunk()
			end)
			return "<Ignore>"
		end)
		:mode("n")
		:buffer(buf)
		:desc("git: Goto next hunk")
		:set()
	map("[g", function()
			if vim.wo.diff then
				return "[g"
			end
			vim.schedule(function()
				actions.prev_hunk()
			end)
			return "<Ignore>"
		end)
		:mode("n")
		:buffer(buf)
		:desc("git: Goto prev hunk")
		:set()
	map("<LEADER>hs", actions.stage_hunk):mode("n"):buffer(buf):desc("git: Stage hunk"):set()
	map("<LEADER>hs", function()
			actions.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end)
		:mode("v")
		:buffer(buf)
		:desc("git: Stage hunk")
		:set()
	map("<LEADER>hu", actions.undo_stage_hunk):mode("n"):buffer(buf):desc("git: Undo stage hunk"):set()
	map("<LEADER>hr", actions.reset_hunk):mode("n"):buffer(buf):desc("git: Reset hunk"):set()
	map("<LEADER>hr", function()
			actions.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end)
		:mode("v")
		:buffer(buf)
		:desc("git: Reset hunk")
		:set()
	map("<LEADER>hR", actions.reset_buffer):mode("n"):buffer(buf):desc("git: Reset buffer"):set()
	map("<LEADER>hp", actions.preview_hunk):mode("n"):buffer(buf):desc("git: Preview buffer"):set()
	map("<LEADER>hb", function()
			actions.blame_line({
				full = true,
			})
		end)
		:mode("n")
		:buffer(buf)
		:desc("git: Blame line")
		:set()
	-- Text objects
	-- map("kn", actions.text_object):mode("ox"):buffer(buf):set()
end

return mapping
