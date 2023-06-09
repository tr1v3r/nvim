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
map("tx", ":r !figlet"):space():noremap():set()

-- Set wrap
map("<LEADER>sw", ":set wrap<CR>"):noremap():silent():set()

-- ==================== Plugins Keymaps ====================
local setEditorPlugKeys = function()
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
    map("<C-\\>", 'execute v:count . "ToggleTerm direction=horizontal"'):mode("n"):noremap():silent():desc(
        "terminal: Toggle horizontal"):set()
    map("<C-\\>", "<Esc><Cmd>ToggleTerm direction=horizontal<CR>"):mode("i"):noremap():silent():desc(
        "terminal: Toggle horizontal"):set()
    map("<C-\\>", "<Cmd>ToggleTerm<CR>"):mode("t"):noremap():silent():desc("terminal: Toggle horizontal"):set()
    map("<A-\\>", [[execute v:count . "ToggleTerm direction=vertical"]]):mode("n"):cr():noremap():silent():desc(
        "terminal: Toggle vertical"):set()
    map("<A-\\>", "<Esc><Cmd>ToggleTerm direction=vertical<CR>"):mode("i"):noremap():silent():desc(
        "terminal: Toggle vertical"):set()
    map("<A-\\>", "<Cmd>ToggleTerm<CR>"):mode("t"):noremap():silent():desc("terminal: Toggle vertical"):set()
    map("<F7>", [[execute v:count . "ToggleTerm direction=vertical"]]):mode("n"):noremap():silent():desc(
        "terminal: Toggle vertical"):set()
    map("<F7>", "<Esc><Cmd>ToggleTerm direction=vertical<CR>"):mode("i"):noremap():silent():desc(
        "terminal: Toggle vertical"):set()
    map("<F7>", "<Cmd>ToggleTerm<CR>"):mode("t"):noremap():silent():desc("terminal: Toggle vertical"):set()
    map("<A-d>", [[execute v:count . "ToggleTerm direction=float"]]):mode("n"):noremap():silent():desc(
        "terminal: Toggle float"):set()
    map("<A-d>", "<Esc><Cmd>ToggleTerm direction=float<CR>"):mode("i"):noremap():silent():desc("terminal: Toggle float")
        :set()
    map("<A-d>", "<Cmd>ToggleTerm<CR>"):mode("t"):noremap():silent():desc("terminal: Toggle float"):set()
    map("<LEADER>g"):mode("n"):callback(function()
        _toggle_lazygit()
    end):noremap():silent():desc("git: Toggle lazygit"):set()

    -- Plugin: trouble
    map("gt", "TroubleToggle"):mode("n"):cr():noremap():silent():desc("lsp: Toggle trouble list"):set()
    map("<LEADER>tr", "TroubleToggle lsp_references"):mode("n"):cr():noremap():silent():desc("lsp: Show lsp references")
        :set()
    map("<LEADER>td", "TroubleToggle document_diagnostics"):mode("n"):cr():noremap():silent():desc(
        "lsp: Show document diagnostics"):set()
    map("<LEAEDR>tw", "TroubleToggle workspace_diagnostics"):mode("n"):cr():noremap():silent():desc(
        "lsp: Show workspace diagnostics"):set()
    map("<LEADER>tq", "TroubleToggle quickfix"):mode("n"):cr():noremap():silent():desc("lsp: Show loclist"):set()
    map("<LEADER>tl", "TroubleToggle loclist"):mode("n"):cr():noremap():silent():desc("lsp: Show loclist"):set()

    -- Plugin: telescope
    map("<C-p>"):mode("n"):callback(function()
        _command_panel()
    end):noremap():silent():desc("tool: Toggle command panel"):set()
    map("<LEADER>u"):mode("n"):callback(function()
        require("telescope").extensions.undo.undo()
    end):noremap():silent():desc("edit: Show undo history"):set()
    map("<LEADER>fp"):mode("n"):callback(function()
        require("telescope").extensions.projects.projects({})
    end):noremap():silent():desc("find: Project"):set()
    map("<LEADER>fr"):mode("n"):callback(function()
        require("telescope").extensions.frecency.frecency()
    end):noremap():silent():desc("find: File by frecency"):set()
    map("<LEADER>fw"):mode("n"):callback(function()
        require("telescope").extensions.live_grep_args.live_grep_args()
    end):noremap():silent():desc("find: Word in project"):set()
    map("<LEADER>fe", "Telescope oldfiles"):mode("n"):pure():noremap():silent():desc("find: File by history"):set()
    map("<LEADER>ff", "Telescope find_files"):mode("n"):pure():noremap():silent():desc("find: File in project"):set()
    map("<LEADER>fc", "Telescope colorscheme"):mode("n"):pure():noremap():silent():desc(
        "ui: Change colorscheme for current session"):set()
    map("<LEADER>fn", ":enew"):mode("n"):pure():noremap():silent():desc("buffer: New"):set()
    map("<LEADER>fg", "Telescope git_files"):mode("n"):pure():noremap():silent():desc("find: File in git project"):set()
    map("<LEADER>fz", "Telescope zoxide list"):mode("n"):pure():noremap():silent():desc(
        "edit: Change current direrctory by zoxide"):set()
    map("<LEADER>fb", "Telescope buffers"):mode("n"):pure():noremap():silent():desc("find: Buffer opened"):set()
    map("<LEADER>fs", "Telescope grep_string"):mode("n"):pure():noremap():silent():desc("find: Current word"):set()

    -- Plugin: dap
    map("<F5>"):mode("n"):callback(function()
        require("dap").continue()
    end):noremap():silent():desc("debug: Run/Continue"):set()
    map("<F6>"):mode("n"):callback(function()
        require("dap").terminate()
        require("dapui").close()
    end):noremap():silent():desc("debug: Stop"):set()
    map("<F8>"):mode("n"):callback(function()
        require("dap").toggle_breakpoint()
    end):noremap():silent():desc("debug: Toggle breakpoint"):set()
    map("<F9>"):mode("n"):callback(function()
        require("dap").step_into()
    end):noremap():silent():desc("debug: Step into"):set()
    map("<F10>"):mode("n"):callback(function()
        require("dap").step_out()
    end):noremap():silent():desc("debug: Step out"):set()
    map("<F11>"):mode("n"):callback(function()
        require("dap").step_over()
    end):noremap():silent():desc("debug: Step over"):set()
    map("<LEADER>db"):mode("n"):callback(function()
        require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
    end):noremap():silent():desc("debug: Set breakpoint with condition"):set()
    map("<LEADER>dc"):mode("n"):callback(function()
        require("dap").run_to_cursor()
    end):noremap():silent():desc("debug: Run to cursor"):set()
    map("<LEADER>dl"):mode("n"):callback(function()
        require("dap").run_last()
    end):noremap():silent():desc("debug: Run last"):set()
    map("<LEADER>do"):mode("n"):callback(function()
        require("dap").repl.open()
    end):noremap():silent():desc("debug: Open REPL"):set()
end

local setPlugKeys = function()
    setEditorPlugKeys()
end

setPlugKeys()
