local map = require"helper.mapping".map

-- =============== Basic Key Mapping ================
-- Leader key
vim.g.mapleader = " "

map("s", "<nop>"):noremap():silent():set()

-- Undo
map("l", "u"):noremap():silent():set()

-- Insert Key
map("k", "i"):noremap():silent():set()
map("K", "I"):noremap():silent():set()

-- Find pair
map(",.", "%"):noremap():silent():set()

-- Search
map("<LEADER><CR>", ":nohlsearch<CR>"):noremap():silent():set()

-- Adjacent duplicate words
map("<LEADER>dw", [[/\(\<\w\+\>\)\_s*\1]]):noremap():set()

-- Find and replace
map([[\s]], ":%s//g<left><left>"):noremap():set()

-- Find and delete (line)
map([[\d]], ":g//d<left><left>"):noremap():set()

-- Copy to system clipboard
map("Y", '"+y'):mode("v"):noremap():silent():set()

-- Space to Tab
map("<LEADER>tt", [[:%s/    /\t/g]]):mode("n"):noremap():silent():set()
map("<LEADER>tt", [[:s/    /\t/g]]):mode("v"):noremap():silent():set()

-- Folding
map("<LEADER>o", "za"):noremap():set()

-- Move cursor in find results
map("=", "nzz"):noremap():set()
map("-", "Nzz"):noremap():set()

-- Quit key
map("S", ":w<CR>"):mode("n"):noremap():silent():set()
map("Q", ":quitall<CR>"):mode("n"):noremap():silent():set()

map(";", ":"):noremap():set()
map("`", "~"):noremap():set()

-- ==================== Cursor Movement ====================
-- New cursor movement (the default arrow keys are used for resizing windows)
--     ^
--     u
-- < n   i >
--     e
--     v
map("n", "h"):noremap():silent():set()
map("e", "j"):noremap():silent():set()
map("u", "k"):noremap():silent():set()
map("i", "l"):noremap():silent():set()
map("gu", "gk"):noremap():silent():set()
map("ge", "gj"):noremap():silent():set()
map([[\v]], "v$h"):noremap():silent():set()
map("h", "e"):noremap():silent():set()

-- scroll
map("U", "5k"):noremap():silent():set()
map("E", "5j"):noremap():silent():set()
-- go to start/end of the line
map("N", "0"):noremap():silent():set()
map("I", "$"):noremap():silent():set()
-- fast move
map("W", "5w"):noremap():silent():set()
map("B", "5b"):noremap():silent():set()
-- move up/down the view port without moving the cursor
map("<C-U>", "5<C-y>"):noremap():silent():set()
map("<C-E>", "5<C-e>"):noremap():silent():set()

-- Custom cursor movement
-- source $HOME/.config/nvim/cursor.vim

-- ==================== Insert Mode Cursor Movement ====================
map("<C-a>", "<ESC>A"):mode("i"):noremap():silent():set()

-- ==================== Command Mode Cursor Movement ====================
map("<C-a>", "<Home>"):mode("c"):noremap():silent():set()
map("<C-e>", "<End>"):mode("c"):noremap():silent():set()
map("<C-p>", "<Up>"):mode("c"):noremap():silent():set()
map("<C-n>", "<Down>"):mode("c"):noremap():silent():set()
map("<C-b>", "<Left>"):mode("c"):noremap():silent():set()
map("<C-f>", "<Right>"):mode("c"):noremap():silent():set()
map("<M-b>", "<S-Left>"):mode("c"):noremap():silent():set()
map("<M-w>", "<S-Right>"):mode("c"):noremap():silent():set()

-- ==================== Window management ====================
map("<LEADER>w", "<C-w>w"):noremap():silent():set()
map("<LEADER>u", "<C-w>k"):noremap():silent():set()
map("<LEADER>e", "<C-w>j"):noremap():silent():set()
map("<LEADER>n", "<C-w>h"):noremap():silent():set()
map("<LEADER>i", "<C-w>l"):noremap():silent():set()

-- Close all other windows
map("tq", "<C-w>o"):noremap():silent():set()

-- Split the screens to up/down/left/right
map("su", ":set nosplitbelow<CR>:split<CR>:set splitbelow<CR>"):noremap():silent():set()
map("se", ":set splitbelow<CR>:split<CR>"):noremap():silent():set()
map("sn", ":set nosplitright<CR>:vsplit<CR>:set splitright<CR>"):noremap():silent():set()
map("si", ":set splitright<CR>:vsplit<CR>"):noremap():silent():set()

-- Resize window
map("<up>", ":res +5<CR>"):noremap():silent():set()
map("<down>", ":res -5<CR>"):noremap():silent():set()
map("<left>", ":vertical resize-5<CR>"):noremap():silent():set()
map("<right>", ":vertical resize+5<CR>"):noremap():silent():set()

-- Place the two screens up and down
map("sh", "<C-w>t<C-w>K"):noremap():silent():set()
-- Place the two screens side by side
map("sv", "<C-w>t<C-w>H"):noremap():silent():set()
-- Rotate screens
map("srh", "<C-w>b<C-w>K"):noremap():silent():set()
map("srv", "<C-w>b<C-w>H"):noremap():silent():set()
-- Press <SPACE> + q to close the window below the current window
map("<LEADER>q", "<C-w>j:q<CR>"):noremap():silent():set()

-- Opening a terminal window
-- noremap <LEADER>/ :set splitbelow<CR>:split<CR>:res -5<CR>:term<CRs>i
map("<C-`>", ":set splitbelow<CR>:split<CR>:res -5<CR>:term<CR>i"):noremap():silent():set()

-- Open a new instance of st with the cwd
-- nnoremap \t :tabe<CR>:-tabmove<CR>:term sh -c 'st'<CR><C-\><C-N>:q<CR>
-- Open a new terminal tab
map([[\t]], ":tabe<CR>:term<CR>i"):noremap():silent():set()

-- ==================== Tab management ====================
-- Create a new tab with tu
map("tu", ":tabe<CR>"):noremap():silent():set()
map("tU", ":tab split<CR>"):noremap():silent():set()
-- Move around tabs with tn and ti
map("tn", ":-tabnext<CR>"):noremap():silent():set()
map("ti", ":+tabnext<CR>"):noremap():silent():set()
-- Move the tabs with tN and tI
map("tN", ":-tabmove<CR>"):noremap():silent():set()
map("tI", ":+tabmove<CR>"):noremap():silent():set()

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
map("", ":nn <Leader>0 :tablast<CR>"):exec()

-- Close tab
map("tw", ":tabclose<CR>"):noremap():silent():set()
-- Close all other tabs
map("to", ":tabonly<CR>"):noremap():silent():set()

-- ==================== Other useful stuff ====================
-- Press space twice to jump to the next '<++>' and edit it
map("<LEADER><LEADER>", "<Esc>/<++><CR>:nohlsearch<CR>c4l"):noremap():silent():set()

-- Spelling Check with <space>sc
map("<LEADER>sc", ":set spell!<CR>"):noremap():silent():set()

-- adjust current line to center of screen
map("<C-c>", "zz"):noremap():silent():set()

-- Call figlet
map("tx", ":r !figlet "):noremap():silent():set()

-- Set wrap
map("<LEADER>sw", ":set wrap<CR>"):noremap():silent():set()

-- ==================== Plugins Keymaps ====================
local setPluginKeys = function()
    -- Plugin: vim-fugitive
    map("gps", "G push"):cr():noremap():silent():desc("git: Push"):set()
    map("gpl", "G pull"):cr():noremap():silent():desc("git: Pull"):set()
    map("<LEADER>G", "Git"):pure():noremap():silent():desc("git: Open git-fugitive"):set()

    -- Plugin: nvim-tree
    map("tt", ":NvimTreeToggle<CR>"):noremap():silent():set()
    map("tf", ":NvimTreeFocus<CR>"):noremap():silent():set()

    --  Plugin:lazygit
    map("<C-g>", ":LazyGit<CR>"):noremap():silent():set()

    -- Plugin: sniprun
    map("<LEADER>r", ":SnipRun<CR>"):mode("v"):noremap():silent():desc("tool: Run code by range"):set()
    map("<LEADER>r", ":SnipRun<CR>"):mode("n"):noremap():silent():desc("tool: Run code by file"):set()

    -- -- Plugin: toggleterm
    map("<Esc><Esc>", [[<C-\><C-n>]]):mode("t"):noremap():silent():set() -- switch to normal mode in terminal.
    map("jk", [[<C-\><C-n>]]):mode("t"):noremap():silent():set() -- switch to normal mode in terminal.
    map("<C-\\>", 'execute v:count . "ToggleTerm direction=horizontal"'):mode("n"):noremap():silent():desc("terminal: Toggle horizontal"):set()
    map("<C-\\>","<Esc><Cmd>ToggleTerm direction=horizontal<CR>"):mode("i"):noremap():silent():desc():set()
    map("<C-\\>", "<Cmd>ToggleTerm<CR>"):mode("t"):noremap():silent():desc("terminal: Toggle horizontal"):set()
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
