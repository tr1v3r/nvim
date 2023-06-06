-- =============== Basic Key Mapping ================
-- Leader key
vim.g.mapleader = " "

-- Define common options
-- noremap: non-recursive
-- silent: do not show message
local nsopts = {
    noremap = true,
    silent = true
}
local nopts = {
    noremap = true
}

vim.keymap.set("", "s", "<nop>", nsopts)

-- Undo
vim.keymap.set("", "l", "u", nsopts)
-- Insert Key
vim.keymap.set("", "k", "i", nsopts)
vim.keymap.set("", "K", "I", nsopts)

-- Find pair
vim.keymap.set("", ",.", "%", nsopts)
-- Search
vim.keymap.set("", "<LEADER><CR>", ":nohlsearch<CR>", nsopts)
-- Adjacent duplicate words
vim.keymap.set("", "<LEADER>dw", [[/\(\<\w\+\>\)\_s*\1]], nopts)
-- Find and replace
vim.keymap.set("", [[\s]], ":%s//g<left><left>", nopts)
-- Find and delete (line)
vim.keymap.set("", [[\d]], ":g//d<left><left>", nopts)
-- Copy to system clipboard
vim.keymap.set("v", "Y", '"+y', nsopts)
-- Space to Tab
vim.keymap.set("n", "<LEADER>tt", [[:%s/    /\t/g]], nopts)
vim.keymap.set("v", "<LEADER>tt", [[:s/    /\t/g]], nopts)
-- Folding
vim.keymap.set("", "<LEADER>o", "za", nsopts)

-- Move cursor in find results
vim.keymap.set("", "=", "nzz", nopts)
vim.keymap.set("", "-", "Nzz", nopts)

-- Quit key
vim.keymap.set("n", "S", ":w<CR>", nsopts)
vim.keymap.set("n", "Q", ":quitall<CR>", nopts)

vim.keymap.set("", ";", ":", nopts)
vim.keymap.set("", "`", "~", nopts)

-- ==================== Cursor Movement ====================
-- New cursor movement (the default arrow keys are used for resizing windows)
--     ^
--     u
-- < n   i >
--     e
--     v
vim.keymap.set("", "n", "h", nsopts)
vim.keymap.set("", "e", "j", nsopts)
vim.keymap.set("", "u", "k", nsopts)
vim.keymap.set("", "i", "l", nsopts)
vim.keymap.set("", "gu", "gk", nsopts)
vim.keymap.set("", "ge", "gj", nsopts)
vim.keymap.set("", [[\v]], "v$h", nsopts)
vim.keymap.set("", "h", "e", nsopts)

-- scroll
vim.keymap.set("", "U", "5k", nsopts)
vim.keymap.set("", "E", "5j", nsopts)
-- go to start/end of the line
vim.keymap.set("", "N", "0", nsopts)
vim.keymap.set("", "I", "$", nsopts)
-- fast move
vim.keymap.set("", "W", "5w", nsopts)
vim.keymap.set("", "B", "5b", nsopts)
-- move up/down the view port without moving the cursor
vim.keymap.set("", "<C-U>", "5<C-y>", nsopts)
vim.keymap.set("", "<C-E>", "5<C-e>", nsopts)

-- Custom cursor movement
-- source $HOME/.config/nvim/cursor.vim

-- ==================== Insert Mode Cursor Movement ====================
vim.keymap.set("i", "<C-a>", "<ESC>A", nsopts)

-- ==================== Command Mode Cursor Movement ====================
vim.keymap.set("c", "<C-a>", "<Home>", nsopts)
vim.keymap.set("c", "<C-e>", "<End>", nsopts)
vim.keymap.set("c", "<C-p>", "<Up>", nsopts)
vim.keymap.set("c", "<C-n>", "<Down>", nsopts)
vim.keymap.set("c", "<C-b>", "<Left>", nsopts)
vim.keymap.set("c", "<C-f>", "<Right>", nsopts)
vim.keymap.set("c", "<M-b>", "<S-Left>", nsopts)
vim.keymap.set("c", "<M-w>", "<S-Right>", nsopts)

-- ==================== Window management ====================
vim.keymap.set("", "<LEADER>w", "<C-w>w", nsopts)
vim.keymap.set("", "<LEADER>u", "<C-w>k", nsopts)
vim.keymap.set("", "<LEADER>e", "<C-w>j", nsopts)
vim.keymap.set("", "<LEADER>n", "<C-w>h", nsopts)
vim.keymap.set("", "<LEADER>i", "<C-w>l", nsopts)

-- Close all other windows
vim.keymap.set("", "tq", "<C-w>o", nsopts)

-- Split the screens to up/down/left/right
vim.keymap.set("", "su", ":set nosplitbelow<CR>:split<CR>:set splitbelow<CR>", nsopts)
vim.keymap.set("", "se", ":set splitbelow<CR>:split<CR>", nsopts)
vim.keymap.set("", "sn", ":set nosplitright<CR>:vsplit<CR>:set splitright<CR>", nsopts)
vim.keymap.set("", "si", ":set splitright<CR>:vsplit<CR>", nsopts)

-- Resize window
vim.keymap.set("", "<up>", ":res +5<CR>", nsopts)
vim.keymap.set("", "<down>", ":res -5<CR>", nsopts)
vim.keymap.set("", "<left>", ":vertical resize-5<CR>", nsopts)
vim.keymap.set("", "<right>", ":vertical resize+5<CR>", nsopts)

-- Place the two screens up and down
vim.keymap.set("", "sh", "<C-w>t<C-w>K", nsopts)
-- Place the two screens side by side
vim.keymap.set("", "sv", "<C-w>t<C-w>H", nsopts)
-- Rotate screens
vim.keymap.set("", "srh", "<C-w>b<C-w>K", nsopts)
vim.keymap.set("", "srv", "<C-w>b<C-w>H", nsopts)
-- Press <SPACE> + q to close the window below the current window
vim.keymap.set("", "<LEADER>q", "<C-w>j:q<CR>", nsopts)

-- Opening a terminal window
-- noremap <LEADER>/ :set splitbelow<CR>:split<CR>:res -5<CR>:term<CRs>i
vim.keymap.set("", "<C-`>", ":set splitbelow<CR>:split<CR>:res -5<CR>:term<CR>i", nsopts)

-- Open a new instance of st with the cwd
-- nnoremap \t :tabe<CR>:-tabmove<CR>:term sh -c 'st'<CR><C-\><C-N>:q<CR>
-- Open a new terminal tab
vim.keymap.set("", [[\t]], ":tabe<CR>:term<CR>i", nsopts)

-- ==================== Tab management ====================
-- Create a new tab with tu
vim.keymap.set("", "tu", ":tabe<CR>", nsopts)
vim.keymap.set("", "tU", ":tab split<CR>", nsopts)
-- Move around tabs with tn and ti
vim.keymap.set("", "tn", ":-tabnext<CR>", nsopts)
vim.keymap.set("", "ti", ":+tabnext<CR>", nsopts)
-- Move the tabs with tN and tI
vim.keymap.set("", "tN", ":-tabmove<CR>", nsopts)
vim.keymap.set("", "tI", ":+tabmove<CR>", nsopts)

-- Tab switch
vim.cmd(":nn <Leader>1 1gt")
vim.cmd(":nn <Leader>2 2gt")
vim.cmd(":nn <Leader>3 3gt")
vim.cmd(":nn <Leader>4 4gt")
vim.cmd(":nn <Leader>5 5gt")
vim.cmd(":nn <Leader>6 6gt")
vim.cmd(":nn <Leader>7 7gt")
vim.cmd(":nn <Leader>8 8gt")
vim.cmd(":nn <Leader>9 9gt")
vim.cmd(":nn <Leader>0 :tablast<CR>")

-- Close tab
vim.keymap.set("", "tw", ":tabclose<CR>", nsopts)
-- Close all other tabs
vim.keymap.set("", "to", ":tabonly<CR>", nsopts)

-- ==================== Other useful stuff ====================
-- Press space twice to jump to the next '<++>' and edit it
vim.keymap.set("", "<LEADER><LEADER>", "<Esc>/<++><CR>:nohlsearch<CR>c4l", nsopts)

-- Spelling Check with <space>sc
vim.keymap.set("", "<LEADER>sc", ":set spell!<CR>", nsopts)

-- adjust current line to center of screen
vim.keymap.set("", "<C-c>", "zz", nsopts)

-- Call figlet
vim.keymap.set("", "tx", ":r !figlet ", nopts)

-- Set wrap
vim.keymap.set("", "<LEADER>sw", ":set wrap<CR>", nsopts)

-- ==================== Plugins Keymaps ====================
local setPluginKeys = function()
    -- Plugin: vim-fugitive
    -- ["n|gps"] = map_cr("G push"):with_noremap():with_silent():with_desc("git: Push"),
    -- ["n|gpl"] = map_cr("G pull"):with_noremap():with_silent():with_desc("git: Pull"),
    -- ["n|<leader>G"] = map_cu("Git"):with_noremap():with_silent():with_desc("git: Open git-fugitive"),

    -- Plugin: nvim-tree
    vim.keymap.set("", "tt", ":NvimTreeToggle<CR>", nsopts)
    vim.keymap.set("", "tf", ":NvimTreeFocus<CR>", nsopts)

    --  Plugin:lazygit
    vim.keymap.set("", "<C-g>", ":LazyGit<CR>", nsopts)

    -- Plugin: sniprun
    vim.keymap.set("v", "<LEADER>r", ":SnipRun<CR>", nsopts) -- tool: Run code by range
    vim.keymap.set("n", "<LEADER>r", ":SnipRun<CR>", nsopts) -- tool: Run code by file

    -- -- Plugin: toggleterm
	-- ["t|<Esc><Esc>"] = map_cmd([[<C-\><C-n>]]):with_noremap():with_silent(), -- switch to normal mode in terminal.
	-- ["t|jk"] = map_cmd([[<C-\><C-n>]]):with_noremap():with_silent(), -- switch to normal mode in terminal.
	-- ["n|<C-\\>"] = map_cr([[execute v:count . "ToggleTerm direction=horizontal"]])
	-- 	:with_noremap()
	-- 	:with_silent()
	-- 	:with_desc("terminal: Toggle horizontal"),
	-- ["i|<C-\\>"] = map_cmd("<Esc><Cmd>ToggleTerm direction=horizontal<CR>")
	-- 	:with_noremap()
	-- 	:with_silent()
	-- 	:with_desc("terminal: Toggle horizontal"),
	-- ["t|<C-\\>"] = map_cmd("<Cmd>ToggleTerm<CR>"):with_noremap():with_silent():with_desc("terminal: Toggle horizontal"),
	-- ["n|<A-\\>"] = map_cr([[execute v:count . "ToggleTerm direction=vertical"]])
	-- 	:with_noremap()
	-- 	:with_silent()
	-- 	:with_desc("terminal: Toggle vertical"),
	-- ["i|<A-\\>"] = map_cmd("<Esc><Cmd>ToggleTerm direction=vertical<CR>")
	-- 	:with_noremap()
	-- 	:with_silent()
	-- 	:with_desc("terminal: Toggle vertical"),
	-- ["t|<A-\\>"] = map_cmd("<Cmd>ToggleTerm<CR>"):with_noremap():with_silent():with_desc("terminal: Toggle vertical"),
	-- ["n|<F5>"] = map_cr([[execute v:count . "ToggleTerm direction=vertical"]])
	-- 	:with_noremap()
	-- 	:with_silent()
	-- 	:with_desc("terminal: Toggle vertical"),
	-- ["i|<F5>"] = map_cmd("<Esc><Cmd>ToggleTerm direction=vertical<CR>")
	-- 	:with_noremap()
	-- 	:with_silent()
	-- 	:with_desc("terminal: Toggle vertical"),
	-- ["t|<F5>"] = map_cmd("<Cmd>ToggleTerm<CR>"):with_noremap():with_silent():with_desc("terminal: Toggle vertical"),
	-- ["n|<A-d>"] = map_cr([[execute v:count . "ToggleTerm direction=float"]])
	-- 	:with_noremap()
	-- 	:with_silent()
	-- 	:with_desc("terminal: Toggle float"),
	-- ["i|<A-d>"] = map_cmd("<Esc><Cmd>ToggleTerm direction=float<CR>")
	-- 	:with_noremap()
	-- 	:with_silent()
	-- 	:with_desc("terminal: Toggle float"),
	-- ["t|<A-d>"] = map_cmd("<Cmd>ToggleTerm<CR>"):with_noremap():with_silent():with_desc("terminal: Toggle float"),
	-- ["n|<leader>g"] = map_callback(function()
	-- 		_toggle_lazygit()
	-- 	end)
	-- 	:with_noremap()
	-- 	:with_silent()
	-- 	:with_desc("git: Toggle lazygit"),

	-- -- Plugin: trouble
	-- ["n|gt"] = map_cr("TroubleToggle"):with_noremap():with_silent():with_desc("lsp: Toggle trouble list"),
	-- ["n|<leader>tr"] = map_cr("TroubleToggle lsp_references")
	-- 	:with_noremap()
	-- 	:with_silent()
	-- 	:with_desc("lsp: Show lsp references"),
	-- ["n|<leader>td"] = map_cr("TroubleToggle document_diagnostics")
	-- 	:with_noremap()
	-- 	:with_silent()
	-- 	:with_desc("lsp: Show document diagnostics"),
	-- ["n|<leader>tw"] = map_cr("TroubleToggle workspace_diagnostics")
	-- 	:with_noremap()
	-- 	:with_silent()
	-- 	:with_desc("lsp: Show workspace diagnostics"),
	-- ["n|<leader>tq"] = map_cr("TroubleToggle quickfix")
	-- 	:with_noremap()
	-- 	:with_silent()
	-- 	:with_desc("lsp: Show quickfix list"),
	-- ["n|<leader>tl"] = map_cr("TroubleToggle loclist"):with_noremap():with_silent():with_desc("lsp: Show loclist"),

	-- -- Plugin: telescope
	-- ["n|<C-p>"] = map_callback(function()
	-- 		_command_panel()
	-- 	end)
	-- 	:with_noremap()
	-- 	:with_silent()
	-- 	:with_desc("tool: Toggle command panel"),
	-- ["n|<leader>u"] = map_callback(function()
	-- 		require("telescope").extensions.undo.undo()
	-- 	end)
	-- 	:with_noremap()
	-- 	:with_silent()
	-- 	:with_desc("edit: Show undo history"),
	-- ["n|<leader>fp"] = map_callback(function()
	-- 		require("telescope").extensions.projects.projects({})
	-- 	end)
	-- 	:with_noremap()
	-- 	:with_silent()
	-- 	:with_desc("find: Project"),
	-- ["n|<leader>fr"] = map_callback(function()
	-- 		require("telescope").extensions.frecency.frecency()
	-- 	end)
	-- 	:with_noremap()
	-- 	:with_silent()
	-- 	:with_desc("find: File by frecency"),
	-- ["n|<leader>fw"] = map_callback(function()
	-- 		require("telescope").extensions.live_grep_args.live_grep_args()
	-- 	end)
	-- 	:with_noremap()
	-- 	:with_silent()
	-- 	:with_desc("find: Word in project"),
	-- ["n|<leader>fe"] = map_cu("Telescope oldfiles"):with_noremap():with_silent():with_desc("find: File by history"),
	-- ["n|<leader>ff"] = map_cu("Telescope find_files"):with_noremap():with_silent():with_desc("find: File in project"),
	-- ["n|<leader>fc"] = map_cu("Telescope colorscheme")
	-- 	:with_noremap()
	-- 	:with_silent()
	-- 	:with_desc("ui: Change colorscheme for current session"),
	-- ["n|<leader>fn"] = map_cu(":enew"):with_noremap():with_silent():with_desc("buffer: New"),
	-- ["n|<leader>fg"] = map_cu("Telescope git_files")
	-- 	:with_noremap()
	-- 	:with_silent()
	-- 	:with_desc("find: file in git project"),
	-- ["n|<leader>fz"] = map_cu("Telescope zoxide list")
	-- 	:with_noremap()
	-- 	:with_silent()
	-- 	:with_desc("edit: Change current direrctory by zoxide"),
	-- ["n|<leader>fb"] = map_cu("Telescope buffers"):with_noremap():with_silent():with_desc("find: Buffer opened"),
	-- ["n|<leader>fs"] = map_cu("Telescope grep_string"):with_noremap():with_silent():with_desc("find: Current word"),

	-- -- Plugin: dap
	-- ["n|<F6>"] = map_callback(function()
	-- 		require("dap").continue()
	-- 	end)
	-- 	:with_noremap()
	-- 	:with_silent()
	-- 	:with_desc("debug: Run/Continue"),
	-- ["n|<F7>"] = map_callback(function()
	-- 		require("dap").terminate()
	-- 		require("dapui").close()
	-- 	end)
	-- 	:with_noremap()
	-- 	:with_silent()
	-- 	:with_desc("debug: Stop"),
	-- ["n|<F8>"] = map_callback(function()
	-- 		require("dap").toggle_breakpoint()
	-- 	end)
	-- 	:with_noremap()
	-- 	:with_silent()
	-- 	:with_desc("debug: Toggle breakpoint"),
	-- ["n|<F9>"] = map_callback(function()
	-- 		require("dap").step_into()
	-- 	end)
	-- 	:with_noremap()
	-- 	:with_silent()
	-- 	:with_desc("debug: Step into"),
	-- ["n|<F10>"] = map_callback(function()
	-- 		require("dap").step_out()
	-- 	end)
	-- 	:with_noremap()
	-- 	:with_silent()
	-- 	:with_desc("debug: Step out"),
	-- ["n|<F11>"] = map_callback(function()
	-- 		require("dap").step_over()
	-- 	end)
	-- 	:with_noremap()
	-- 	:with_silent()
	-- 	:with_desc("debug: Step over"),
	-- ["n|<leader>db"] = map_callback(function()
	-- 		require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
	-- 	end)
	-- 	:with_noremap()
	-- 	:with_silent()
	-- 	:with_desc("debug: Set breakpoint with condition"),
	-- ["n|<leader>dc"] = map_callback(function()
	-- 		require("dap").run_to_cursor()
	-- 	end)
	-- 	:with_noremap()
	-- 	:with_silent()
	-- 	:with_desc("debug: Run to cursor"),
	-- ["n|<leader>dl"] = map_callback(function()
	-- 		require("dap").run_last()
	-- 	end)
	-- 	:with_noremap()
	-- 	:with_silent()
	-- 	:with_desc("debug: Run last"),
	-- ["n|<leader>do"] = map_callback(function()
	-- 		require("dap").repl.open()
	-- 	end)
	-- 	:with_noremap()
	-- 	:with_silent()
	-- 	:with_desc("debug: Open REPL"),
end

setPluginKeys()
