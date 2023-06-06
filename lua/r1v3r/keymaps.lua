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

vim.keymap.set("", "tt", ":NvimTreeToggle<CR>", nsopts)
vim.keymap.set("", "tf", ":NvimTreeFocus<CR>", nsopts)

vim.keymap.set("", "<C-g>", ":LazyGit<CR>", nsopts)
