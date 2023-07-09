local map = require("helper.mapping").map
local et = require("helper.mapping").escape_termcode
require("helper.plugins")

-- =============== Basic Key Mapping ================
-- Leader key
vim.g.mapleader = " "

local setGeneralKeys = function()
    -- map("s", "<nop>"):noremap():silent():set()

    -- Undo
    map("l", "u"):noremap():silent():set()

    -- Insert Key
    map("k", "i"):noremap():silent():set()
    map("K", "I"):noremap():silent():set()

    -- Find pair
    map(",.", "%"):noremap():silent():set()

    -- Search
    map("<LEADER><CR>", ":nohlsearch<CR>"):noremap():silent():desc("edit: nohl"):set()

    -- Adjacent duplicate words
    map("<LEADER>dw", [[/\(\<\w\+\>\)\_s*\1]]):noremap():desc("edit: find adjacent duplicate words"):set()

    -- Find and replace
    map([[\s]], ":%s//g<left><left>"):noremap():desc("edit: find and replace string in current file"):set()
    map([[\S]], [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]):mode("n"):noremap():desc(
        "edit: find and replace all current word"):set()

    -- Find and delete (line)
    map([[\d]], ":g//d<left><left>"):noremap():desc("edit: find and delete"):set()

    -- Copy to system clipboard
    -- map("Y", [["+y]]):mode("v"):noremap():silent():desc("edit: copy to system clipboard"):set()

    -- Space to Tab
    map("<LEADER>tt", [[:%s/    /\t/g]]):mode("n"):noremap():silent():desc("edit: replace space to tab"):set()
    map("<LEADER>tt", [[:s/    /\t/g]]):mode("v"):noremap():silent():desc("edit: replace space to tab"):set()

    -- Folding
    map("<LEADER>o", "za"):noremap():desc("edit: folding"):set()

    -- Move cursor in find results
    map("=", "nzz"):noremap():set()
    map("-", "Nzz"):noremap():set()

    -- Quit key
    map("S", ":w<CR>"):mode("n"):noremap():silent():desc("edit: save file"):set()
    map("Q", ":quitall<CR>"):mode("n"):noremap():silent():set()

    map(";", ":"):noremap():desc("edit: key replace"):set()
    map("`", "~"):noremap():desc("edit: key replace"):set()

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
    map("h", "e"):noremap():silent():set()

    map([[\v]], "v$h"):noremap():silent():desc("edit: select content from cursor to line end"):set()

    -- scroll
    map("U", "12k"):noremap():silent():set()
    map("E", "12j"):noremap():silent():set()
    -- map("U", ":m '<-2<CR>gv=gv"):noremap():silent():set() -- move selected block move up
    -- map("E", ":m '>+1<CR>gv=gv"):noremap():silent():set() -- move selected block move down
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

    -- ==================== Copy/Paste ====================
    map("<LEADER>p", [["_dp]]):mode("x"):noremap():silent():desc("edit: replace block without change clipboard"):set()

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
    -- map("<LEADER>w", "<C-w>w"):noremap():silent():set()
    map("<LEADER>u", "<C-w>k"):noremap():silent():set()
    map("<LEADER>e", "<C-w>j"):noremap():silent():set()
    map("<LEADER>n", "<C-w>h"):noremap():silent():set()
    map("<LEADER>i", "<C-w>l"):noremap():silent():set()

    map("tq", "<C-w>o"):noremap():silent():desc("window: close or other windows"):set()

    -- Split the screens to up/down/left/right
    map("su", ":set nosplitbelow<CR>:split<CR>:set splitbelow<CR>"):mode("n"):noremap():silent():desc("window: split up"):set()
    map("se", ":set splitbelow<CR>:split<CR>"):mode("n"):noremap():silent():desc("window: split down"):set()
    map("sn", ":set nosplitright<CR>:vsplit<CR>:set splitright<CR>"):mode("n"):noremap():silent():desc("windown: split left"):set()
    map("si", ":set splitright<CR>:vsplit<CR>"):mode("n"):noremap():silent():desc("window: split right"):set()

    -- Resize window
    map("<up>", ":res +5<CR>"):noremap():silent():desc("window: expand window size"):set()
    map("<down>", ":res -5<CR>"):noremap():silent():desc("window: shorten window size"):set()
    map("<left>", ":vertical resize-5<CR>"):noremap():silent():desc("window: vertical expand window size"):set()
    map("<right>", ":vertical resize+5<CR>"):noremap():silent():desc("window: vertical shorten window size"):set()

    map("sh", "<C-w>t<C-w>K"):mode("n"):noremap():silent():desc("window: place the two windows up and down"):set()
    map("sv", "<C-w>t<C-w>H"):mode("n"):noremap():silent():desc("window: Place the two windows side by side"):set()
    map("srh", "<C-w>b<C-w>K"):mode("n"):noremap():silent():desc("window: rotate windows"):set()
    map("srv", "<C-w>b<C-w>H"):mode("n"):noremap():silent():desc("window: rotate windows"):set()

    map("<LEADER>q", "<C-w>j:q<CR>"):noremap():silent():desc("window: close current window"):set()

    -- Opening a terminal window
    local newTermCmd = ":term<CR>:set filetype=terminal<CR>:set norelativenumber<CR>:set nonumber<CR>"
    map("<LEADER>/", ":set splitbelow<CR>:split<CR>:res -5<CR>" .. newTermCmd .. "i"):noremap():silent():desc(
        "window: open terminal window"):set()
    map("<C-`>", ":set splitbelow<CR>:split<CR>:res -5<CR>" .. newTermCmd .. "i"):noremap():silent():desc(
        "window: open terminal window"):set()
    map("<C-\\>", ":set nosplitbelow<CR>:vsplit<CR>:vertical resize-30<CR>" .. newTermCmd .. "i"):noremap():silent()
        :desc("window: open terminal window"):set()
    -- Open a new instance of st with the cwd
    -- nnoremap \t :tabe<CR>:-tabmove<CR>:term sh -c 'st'<CR><C-\><C-N>:q<CR>
    -- Open a new terminal tab
    map([[\t]], ":tabe<CR>:term<CR>i"):noremap():silent():desc("window: open terminal window in new tab"):set()
    map("<Esc><Esc>", [[<C-\><C-n>]]):mode("t"):noremap():silent():desc("edit: switch to normal mode"):set() -- switch to normal mode in terminal.
    -- map("jk", [[<C-\><C-n>]]):mode("t"):noremap():silent():set() -- switch to normal mode in terminal.

    -- ==================== Tab management ====================
    -- Create a new tab with tu
    map("tu", ":tabe<CR>"):noremap():silent():desc("tab: new tab"):set()
    map("tU", ":tab split<CR>"):noremap():silent():desc("tab: new tab and switch"):set()
    -- Move around tabs with tn and ti
    map("tn", ":-tabnext<CR>"):noremap():silent():desc("tab: move to left tab"):set()
    map("ti", ":+tabnext<CR>"):noremap():silent():desc("tab: move to right tab"):set()
    -- Move the tabs with tN and tI
    map("tN", ":-tabmove<CR>"):noremap():silent():desc("tab: move tab to left"):set()
    map("tI", ":+tabmove<CR>"):noremap():silent():desc("tab: move tab to right"):set()

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

    map("tw", ":tabclose<CR>"):noremap():silent():desc("tab: close current tab"):set()
    map("to", ":tabonly<CR>"):noremap():silent():desc("tab: close all other tabs"):set()

    -- ==================== Other useful stuff ====================
    map("<LEADER><LEADER>", "<Esc>/<++><CR>:nohlsearch<CR>c4l"):noremap():silent():desc("edit: jump to the next '<++>' and edit it"):set()

    -- Spelling Check with <space>sc
    map("<LEADER>sc", ":set spell!<CR>"):noremap():silent():desc("edit: spelling check"):set()

    -- adjust current line to center of screen
    map("<C-c>", "zz"):noremap():silent():desc("edit: adjust current line to center of screen"):set()

    -- Set wrap
    map("<LEADER>sw", ":set wrap<CR>"):noremap():silent():desc("edit: set wrap"):set()

    -- Call figlet
    map("tx", ":r !figlet"):space():noremap():desc("tool: call figlet"):set()
end

-- ==================== Plugins Keymaps ====================
local setLazyKeys = function()
    -- Package manager: lazy.nvim
    map("<LEADER>LL", "Lazy"):mode("n"):cr():noremap():silent():nowait():desc("package: Show"):set()
    map("<LEADER>Ls", "Lazy sync"):mode("n"):cr():noremap():silent():nowait():desc("package: Sync"):set()
    map("<LEADER>Lu", "Lazy update"):mode("n"):cr():noremap():silent():nowait():desc("package: Update"):set()
    map("<LEADER>Li", "Lazy install"):mode("n"):cr():noremap():silent():nowait():desc("package: Install"):set()
    map("<LEADER>Ll", "Lazy log"):mode("n"):cr():noremap():silent():nowait():desc("package: Log"):set()
    map("<LEADER>Lc", "Lazy check"):mode("n"):cr():noremap():silent():nowait():desc("package: Check"):set()
    map("<LEADER>Ld", "Lazy debug"):mode("n"):cr():noremap():silent():nowait():desc("package: Debug"):set()
    map("<LEADER>Lp", "Lazy profile"):mode("n"):cr():noremap():silent():nowait():desc("package: Profile"):set()
    map("<LEADER>Lr", "Lazy restore"):mode("n"):cr():noremap():silent():nowait():desc("package: Restore"):set()
    map("<LEADER>Lx", "Lazy clean"):mode("n"):cr():noremap():silent():nowait():desc("package: Clean"):set()
end

local setCompletionPlugKeys = function()
    -- map("<C-f>", "<Cmd>FormatToggle<CR>"):mode("n"):noremap():desc("Formater: Toggle format on save"):set()
end

local setEditorPlugKeys = function()
    -- Plugin: accelerated-jk
    map("u", "<Plug>(accelerated_jk_gk)"):mode("n"):noremap():callback(function()
        return et("<Plug>(accelerated_jk_gk)")
    end):expr():set()
    map("e", "<Plug>(accelerated_jk_gj)"):mode("n"):noremap():callback(function()
        return et("<Plug>(accelerated_jk_gj)")
    end):expr():set()
    map("gu", "<Plug>(accelerated_jk_k)"):mode("n"):noremap():callback(function()
        return et("<Plug>(accelerated_jk_k)")
    end):expr():set()
    map("ge", "<Plug>(accelerated_jk_j)"):mode("n"):noremap():callback(function()
        return et("<Plug>(accelerated_jk_j)")
    end):expr():set()

    -- Plugin: persisted.nvim
    map("<LEADER>ss", "SessionSave"):mode("n"):pure():noremap():silent():desc("session: save"):set()
    map("<LEADER>sl", "SessionLoad"):mode("n"):pure():noremap():silent():desc("session: load current"):set()
    map("<LEADER>sd", "SessionDelete"):mode("n"):pure():noremap():silent():desc("session: delete"):set()

    -- Plugin: nvim-bufdel
    map("<A-q>", "BufDel"):mode("n"):cr():noremap():silent():desc("buffer: Close current"):set()

    -- Plugin: clever-f
    map(","):mode("n"):callback(function()
        return et("<Plug>(clever-f-repeat-forward)")
    end):expr():set()
    -- map(","):mode("n"):callback(function()
    --     return et("<Plug>(clever-f-repeat-back)")
    -- end):expr():set()

    -- Plugin: comment.nvim
    map("<C-/>", "<Plug>(comment_toggle_linewise_current)"):mode("n"):noremap():silent():desc(
        "edit: Toggle comment for line"):set()
    map("<LEADER>cc", "<Plug>(comment_toggle_blockwise_curent)"):mode("n"):noremap():silent():desc(
        "edit: Toggle comment for block"):set()
    map("<C-/>", "<Plug>(comment_toggle_linewise_visual)"):mode("x"):noremap():silent():desc(
        "edit: Toggle comment for line with selection"):set()
    map("<LEADER>cc", "<Plug>(comment_toggle_blockwise_visual)"):mode("x"):noremap():silent():desc(
        "edit: Toggle comment for block with selection"):set()
    -- map("gcc"):mode("n"):callback(function()
    --     return vim.v.count == 0 and et("<Plug>(comment_toggle_linewise_current)") or
    --                et("<Plug>(comment_toggle_linewise_count)")
    -- end):noremap():silent():expr():desc("edit: Toggle comment for line"):set()
    -- map("gbc"):mode("n"):callback(function()
    --     return vim.v.count == 0 and et("<Plug>(comment_toggle_blockwise_current)") or
    --                et("<Plug>(comment_toggle_blockwise_count)")
    -- end):noremap():silent():expr():desc("edit: Toggle comment for block"):set()

    -- Plugin: diffview
    map("<LEADER>DD", "DiffviewOpen"):mode("n"):cr():noremap():silent():desc("git: Show diff"):set()
    map("<LEADER>DW", "DiffviewClose"):mode("n"):cr():noremap():silent():desc("git: Close diff"):set()

    -- Plugin: vim-easy-align
    map("gea", "EasyAlign"):mode("nx"):cr():desc("edit: Align with delimiter"):set()

    -- Plugin: hop
    map("<LEADER>w", "<Cmd>HopWord<CR>"):mode("nv"):noremap():desc("jump: Goto word"):set()
    -- map("<LEADER>j", "<Cmd>HopLine<CR>"):mode("nv"):noremap():desc("jump: Goto line"):set()
    map("<LEADER>k", "<Cmd>HopLine<CR>"):mode("nv"):noremap():desc("jump: Goto line"):set()
    -- map("<LEADER>c", "<Cmd>HopChar1<CR>"):mode("nv"):noremap():desc("jump: Goto one char"):set()
    -- map("<LEADER>cc", "<Cmd>HopChar2<CR>"):mode("nv"):noremap():desc("jump: Goto two chars"):set()

    -- Plugin: treehopper
    map("m", "lua require('tsht').nodes()"):mode("o"):pure():silent():desc("jump: Operate across syntax tree"):set()

    -- Plugin: tabout
    map("<A-n>", "<Plug>(TaboutMulti)"):mode("i"):noremap():silent():desc("edit: Goto end of pair"):set()
    map("<A-i>", "<Plug>(TaboutBackMulti)"):mode("i"):noremap():silent():desc("edit: Goto begin of pair"):set()

    -- Plugin suda.vim
    map("<A-s>", "SudaWrite"):mode("n"):pure():noremap():silent():desc("edit: Save file using sudo"):set()
end

local setLangPlugKeys = function()
    -- Plugin MarkdownPreview
    map("<F12>", "MarkdownPreviewToggle"):mode("n"):cr():noremap():silent():desc("tool: Preview markdown"):set()
end

local setToolPlugKeys = function()
    -- Plugin: vim-fugitive ; using lazggit
    -- map("gps", "G push"):cr():noremap():silent():desc("git: Push"):set()
    -- map("gpl", "G pull"):cr():noremap():silent():desc("git: Pull"):set()
    -- map("<LEADER>G", "Git"):pure():noremap():silent():desc("git: Open git-fugitive"):set()

    -- Plugin: nvim-tree
    map("tt", "NvimTreeFindFileToggle"):mode("n"):cr():noremap():silent():desc("tool: Locate file in nvim-tree"):set()
    map("tr", "NvimTreeRefresh"):mode("n"):cr():noremap():silent():desc("tool: Refresh nvim-Tree"):set()
    -- map("tf", "NvimTreeFocus"):mode("n"):cr():noremap():silent():desc("tree: Focus tree"):set()

    --  Plugin: lazygit
    -- map("<C-g>", ":LazyGit<CR>"):noremap():silent():set()
    map("<C-g>"):mode("n"):callback(function()
        _open_lazygit()
    end):noremap():silent():desc("tool: Toggle lazygit"):set()

    -- Plugin: ranger
    map("R", "Ranger"):mode("n"):cr():noremap():silent():desc("tool: Toggle ranger"):set()

    -- Plugin: sniprun
    map("<LEADER>r", "SnipRun"):mode("v"):cr():noremap():silent():desc("tool: Run code by range"):set()
    map("<LEADER>r", "SnipRun"):mode("n"):cr():noremap():silent():desc("tool: Run code by file"):set()

    -- -- Plugin: toggleterm
    -- map("<C-\\>", 'execute v:count . "ToggleTerm direction=horizontal"'):mode("n"):noremap():silent():desc(
    --     "terminal: Toggle horizontal"):set()
    -- map("<C-\\>", "<Esc><Cmd>ToggleTerm direction=horizontal<CR>"):mode("i"):noremap():silent():desc(
    --     "terminal: Toggle horizontal"):set()
    -- map("<C-\\>", "<Cmd>ToggleTerm<CR>"):mode("t"):noremap():silent():desc("terminal: Toggle horizontal"):set()
    -- map("<A-\\>", [[execute v:count . "ToggleTerm direction=vertical"]]):mode("n"):cr():noremap():silent():desc(
    --     "terminal: Toggle vertical"):set()
    -- map("<A-\\>", "<Esc><Cmd>ToggleTerm direction=vertical<CR>"):mode("i"):noremap():silent():desc(
    --     "terminal: Toggle vertical"):set()
    -- map("<A-\\>", "<Cmd>ToggleTerm<CR>"):mode("t"):noremap():silent():desc("terminal: Toggle vertical"):set()
    -- map("<F7>", [[execute v:count . "ToggleTerm direction=vertical"]]):mode("n"):noremap():silent():desc(
    --     "terminal: Toggle vertical"):set()
    -- map("<F7>", "<Esc><Cmd>ToggleTerm direction=vertical<CR>"):mode("i"):noremap():silent():desc(
    --     "terminal: Toggle vertical"):set()
    -- map("<F7>", "<Cmd>ToggleTerm<CR>"):mode("t"):noremap():silent():desc("terminal: Toggle vertical"):set()
    -- map("<A-d>", [[execute v:count . "ToggleTerm direction=float"]]):mode("n"):noremap():silent():desc(
    --     "terminal: Toggle float"):set()
    -- map("<A-d>", "<Esc><Cmd>ToggleTerm direction=float<CR>"):mode("i"):noremap():silent():desc("terminal: Toggle float")
    --     :set()
    -- map("<A-d>", "<Cmd>ToggleTerm<CR>"):mode("t"):noremap():silent():desc("terminal: Toggle float"):set()

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
    map("<LEADER>U"):mode("n"):callback(function()
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
    map("<LEADER>f*", "Telescope grep_string"):mode("n"):pure():noremap():silent():desc("find: Current word"):set()
    map("<LEADER>fd", "Telescope persisted"):mode("n"):pure():noremap():silent():desc("find: Session"):set()

    -- Plugin: dap & dap-go
    map("<LEADER>du"):mode("n"):callback(function()
        require("dap-go").debug_test()
    end):noremap():silent():desc("debug: Run Current Unit Test"):set()
    map("<LEADER>dU"):mode("n"):callback(function()
        require("dap-go").debug_last_test()
    end):noremap():silent():desc("debug: Run Last Unit Test"):set()
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

    -- Plugin: spectre
    map("<LEADER>F", [[<Cmd>lua require("spectre").open()<CR>i]]):mode("n"):noremap():desc("tool: find and replace")
        :set()
    map("<LEADER>F", [[<Cmd>lua require("spectre").open_visual()<CR>i]]):mode("v"):noremap():desc(
        "tool: find and replace"):set()
end

local setUIPlugKeys = function()
    -- Plugin: bufferline
    map("bw", "bdelete"):mode("n"):cr():noremap():silent():desc("buffer: Close current buffer"):set()
    map("bq", "BufferLineCloseOthers"):mode("n"):cr():noremap():silent():desc("buffer: Close other buffer"):set()
    map("<A-i>", "BufferLineCycleNext"):mode("n"):cr():noremap():silent():desc("buffer: Switch to next"):set()
    map("<A-n>", "BufferLineCyclePrev"):mode("n"):cr():noremap():silent():desc("buffer: Switch to prev"):set()
    map("bI", "BufferLineMoveNext"):mode("n"):cr():noremap():silent():desc("buffer: Move current to next"):set()
    map("bN", "BufferLineMovePrev"):mode("n"):cr():noremap():silent():desc("buffer: Move current to prev"):set()
    map("<LEADER>be", "BufferLineSortByExtension"):mode("n"):cr():noremap():desc("buffer: Sort by extension"):set()
    map("<LEADER>bd", "BufferLineSortByDirectory"):mode("n"):cr():noremap():desc("buffer: Sort by direrctory"):set()
    map("b1", "BufferLineGoToBuffer 1"):mode("n"):cr():noremap():silent():desc("buffer: Goto buffer 1"):set()
    map("b2", "BufferLineGoToBuffer 2"):mode("n"):cr():noremap():silent():desc("buffer: Goto buffer 2"):set()
    map("b3", "BufferLineGoToBuffer 3"):mode("n"):cr():noremap():silent():desc("buffer: Goto buffer 3"):set()
    map("b4", "BufferLineGoToBuffer 4"):mode("n"):cr():noremap():silent():desc("buffer: Goto buffer 4"):set()
    map("b5", "BufferLineGoToBuffer 5"):mode("n"):cr():noremap():silent():desc("buffer: Goto buffer 5"):set()
    map("b6", "BufferLineGoToBuffer 6"):mode("n"):cr():noremap():silent():desc("buffer: Goto buffer 6"):set()
    map("b7", "BufferLineGoToBuffer 7"):mode("n"):cr():noremap():silent():desc("buffer: Goto buffer 7"):set()
    map("b8", "BufferLineGoToBuffer 8"):mode("n"):cr():noremap():silent():desc("buffer: Goto buffer 8"):set()
    map("b9", "BufferLineGoToBuffer 9"):mode("n"):cr():noremap():silent():desc("buffer: Goto buffer 9"):set()
end

local setKeys = function()
    setGeneralKeys()
    if vim.g.vscode then
        print("running in VSC")
    else
        setLazyKeys()
        setCompletionPlugKeys()
        setEditorPlugKeys()
        setLangPlugKeys()
        setToolPlugKeys()
        setUIPlugKeys()
    end
end

setKeys()

local mapping = {}

function mapping.lsp(buf)
    -- LSP-related keymaps, work only when event = { "InsertEnter", "LspStart" }
    map("<LEADER>li", "LspInfo"):mode("n"):cr():buffer(buf):desc("lsp: Info"):set()
    map("<LEADER>lr", "LspRestart"):mode("n"):cr():buffer(buf):nowait():desc("lsp: Restart"):set()
    map("go", "Lspsaga outline"):mode("n"):cr():buffer(buf):desc("lsp: Toggle outline"):set()
    map("g[", "Lspsaga diagnostic_jump_prev"):mode("n"):cr():buffer(buf):desc("lsp: Prev diagnostic"):set()
    map("g]", "Lspsaga diagnostic_jump_next"):mode("n"):cr():buffer(buf):desc("lsp: Next diagnostic"):set()
    map("<LEADER>ld", "Lspsaga show_line_diagnostics"):mode("n"):cr():buffer(buf):desc("lsp: Line diagnostic"):set()
    map("gs"):mode("n"):callback(function()
        vim.lsp.buf.signature_help()
    end):desc("lsp: Signature help"):set()
    -- map("<LEADER>cw", "Lspsaga rename"):mode("n"):cr():buffer(buf):desc("lsp: Rename in file range"):set()
    map("<LEADER>cw", "Lspsaga rename ++project"):mode("n"):cr():buffer(buf):desc("lsp: Rename in project range"):set()
    map("<LEADER>hh", "Lspsaga hover_doc"):mode("n"):cr():buffer(buf):desc("lsp: Show doc"):set()
    map("ga", "Lspsaga code_action"):mode("nv"):cr():buffer(buf):desc("lsp: Code action for cursor"):set()
    map("gD", "Lspsaga peek_definition"):mode("n"):cr():buffer(buf):desc("lsp: Preview definition"):set()
    map("gd", "Lspsaga goto_definition"):mode("n"):cr():buffer(buf):desc("lsp: Goto definition"):set()
    map("gr", "Lspsaga lsp_finder"):mode("n"):cr():buffer(buf):desc("lsp: Show reference"):set()
    map("<LEADER>ci", "Lspsaga incoming_calls"):mode("n"):cr():buffer(buf):desc("lsp: Show incoming calls"):set()
    map("<LEADER>co", "Lspsaga outgoing_calls"):mode("n"):cr():buffer(buf):desc("lsp: Show outgoing calls"):set()
end

function mapping.gitsigns(buf)
    local actions = require("gitsigns.actions")
    map("]g"):mode("n"):callback(function()
        if vim.wo.diff then
            return "]g"
        end
        vim.schedule(function()
            actions.next_hunk()
        end)
        return "<Ignore>"
    end):buffer(buf):expr():desc("git: Goto next hunk"):set()
    map("[g"):mode("n"):callback(function()
        if vim.wo.diff then
            return "[g"
        end
        vim.schedule(function()
            actions.prev_hunk()
        end)
        return "<Ignore>"
    end):buffer(buf):expr():desc("git: Goto prev hunk"):set()
    map("<LEADER>hs"):mode("n"):callback(function()
        actions.stage_hunk()
    end):buffer(buf):desc("git: Stage hunk"):set()
    map("<LEADER>hs"):mode("v"):callback(function()
        actions.stage_hunk({vim.fn.line("."), vim.fn.line("v")})
    end):buffer(buf):desc("git: Stage hunk"):set()
    map("<LEADER>hu"):mode("n"):callback(function()
        actions.undo_stage_hunk()
    end):buffer(buf):desc("git: Undo stage hunk"):set()
    map("<LEADER>hr"):mode("n"):callback(function()
        actions.reset_hunk()
    end):buffer(buf):desc("git: Reset hunk"):set()
    map("<LEADER>hr"):mode("v"):callback(function()
        actions.reset_hunk({vim.fn.line("."), vim.fn.line("v")})
    end):buffer(buf):desc("git: Reset hunk"):set()
    map("<LEADER>hR"):mode("n"):callback(function()
        actions.reset_buffer()
    end):buffer(buf):desc("git: Reset buffer"):set()
    map("<LEADER>hp"):mode("n"):callback(function()
        actions.preview_hunk()
    end):buffer(buf):desc("git: Preview buffer"):set()
    map("<LEADER>hb"):mode("n"):callback(function()
        actions.blame_line({
            full = true
        })
    end):buffer(buf):desc("git: Blame line"):set()
    -- Text objects
    map("kn"):mode("ox"):callback(function()
        actions.text_object()
    end):buffer(buf):set()
end

return mapping
