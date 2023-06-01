-- =============== Basic Key Mapping ================ 

-- Leader key
vim.g.mapleader = ' '

-- Define common options
-- noremap: non-recursive
-- silent: do not show message
local nsopts = {noremap = true, silent = true,}
local nopts = {noremap = true}

vim.keymap.set('n', 's', '<nop>', nsopts)

-- Undo
vim.keymap.set('n', 'l', 'u', nsopts)
-- Insert Key
vim.keymap.set('n', 'k', 'i', nsopts)
vim.keymap.set('n', 'K', 'I', nsopts)

-- Find pair
vim.keymap.set('n', ',.', '%', nsopts)
-- Search
vim.keymap.set('n', '<LEADER><CR>', ':nohlsearch<CR>', nsopts)
-- Adjacent duplicate words
vim.keymap.set('n', '<LEADER>dw', [[/\(\<\w\+\>\)\_s*\1]], nopts)
-- Find and replace
vim.keymap.set('n', [[\s]], ':%s//g<left><left>', nopts)
-- Find and delete (line)
vim.keymap.set('n', [[\d]], ':g//d<left><left>', nopts)
-- Copy to system clipboard
vim.keymap.set('v', 'Y', '"+y', nsopts)
-- Space to Tab
vim.keymap.set('n', '<LEADER>tt', [[:%s/    /\t/g]], nopts)
vim.keymap.set('v', '<LEADER>tt', [[:s/    /\t/g]], nopts)
-- Folding
vim.keymap.set('v', '<LEADER>o', 'za', nsopts)


-- Move cursor in find results
vim.keymap.set('n', '=', 'nzz', nopts)
vim.keymap.set('n', '-', 'Nzz', nopts)

-- Quit key
vim.keymap.set('n', 'S', ':w<CR>', nopts)
vim.keymap.set('n', 'Q', ':quitall<CR>', nopts)
vim.keymap.set('n', 'R', ':source $MYVIMRC<CR>', nopts)

vim.keymap.set('n', ';', ':', nopts)
vim.keymap.set('n', '`', '~', nopts)

-- ==================== Cursor Movement ====================
-- New cursor movement (the default arrow keys are used for resizing windows)
--     ^
--     u
-- < n   i >
--     e
--     v
vim.keymap.set('n', 'n', 'h', nsopts)
vim.keymap.set('n', 'e', 'j', nsopts)
vim.keymap.set('n', 'u', 'k', nsopts)
vim.keymap.set('n', 'i', 'l', nsopts)
vim.keymap.set('n', 'gu', 'gk', nsopts)
vim.keymap.set('n', 'ge', 'gj', nsopts)
vim.keymap.set('n', [[\v]], 'v$h', nsopts)

vim.keymap.set('n', 'h', 'e', nsopts)

-- scroll
vim.keymap.set('n', 'U', '5k', nsopts)
vim.keymap.set('n', 'E', '5j', nsopts)
-- go to start/end of the line
vim.keymap.set('n', 'N', '0', nsopts)
vim.keymap.set('n', 'I', '$', nsopts)
-- fast move
vim.keymap.set('n', 'W', '5w', nsopts)
vim.keymap.set('n', 'B', '5b', nsopts)
-- move up/down the view port without moving the cursor
vim.keymap.set('n', '<C-U>', '5<C-y>', nsopts)
vim.keymap.set('n', '<C-E>', '5<C-e>', nsopts)

-- Custom cursor movement
-- source $HOME/.config/nvim/cursor.vim

-- ==================== Insert Mode Cursor Movement ====================
vim.keymap.set('i', '<C-a>', '<ESC>A', nsopts)


-- ==================== Command Mode Cursor Movement ====================
vim.keymap.set('i', '<C-a>', '<Home>', nsopts)
vim.keymap.set('i', '<C-e>', '<End>', nsopts)
vim.keymap.set('i', '<C-p>', '<Up>', nsopts)
vim.keymap.set('i', '<C-n>', '<Down>', nsopts)
vim.keymap.set('i', '<C-b>', '<Left>', nsopts)
vim.keymap.set('i', '<C-f>', '<Right>', nsopts)
vim.keymap.set('i', '<M-b>', '<S-Left>', nsopts)
vim.keymap.set('i', '<M-w>', '<S-Right>', nsopts)

-- ==================== Window management ====================
vim.keymap.set('n', '<LEADER>w', '<C-w>w', nsopts)
vim.keymap.set('n', '<LEADER>u', '<C-w>k', nsopts)
vim.keymap.set('n', '<LEADER>e', '<C-w>j', nsopts)
vim.keymap.set('n', '<LEADER>n', '<C-w>h', nsopts)
vim.keymap.set('n', '<LEADER>i', '<C-w>l', nsopts)

-- Close all other windows
vim.keymap.set('n', 'tq', '<C-w>o', nsopts)

-- Split the screens to up/down/left/right
vim.keymap.set('n', 'su', ':set nosplitbelow<CR>:split<CR>:set splitbelow<CR>', nsopts)
vim.keymap.set('n', 'se', ':set splitbelow<CR>:split<CR>', nsopts)
vim.keymap.set('n', 'sn', ':set nosplitright<CR>:vsplit<CR>:set splitright<CR>', nsopts)
vim.keymap.set('n', 'si', ':set splitright<CR>:vsplit<CR>', nsopts)

-- Resize window
vim.keymap.set('n', '<up>', ':res +5<CR>', nsopts)
vim.keymap.set('n', '<down>', ':res -5<CR>', nsopts)
vim.keymap.set('n', '<left>', ':vertical resize-5<CR>', nsopts)
vim.keymap.set('n', '<right>', ':vertical resize+5<CR>', nsopts)

-- Place the two screens up and down
vim.keymap.set('n', 'sh', '<C-w>t<C-w>K', nsopts)
-- Place the two screens side by side
vim.keymap.set('n', 'sv', '<C-w>t<C-w>H', nsopts)
-- Rotate screens
vim.keymap.set('n', 'srh', '<C-w>b<C-w>K', nsopts)
vim.keymap.set('n', 'srv', '<C-w>b<C-w>H', nsopts)
-- Press <SPACE> + q to close the window below the current window
vim.keymap.set('n', '<LEADER>q', '<C-w>j:q<CR>', nsopts)

-- Opening a terminal window
-- noremap <LEADER>/ :set splitbelow<CR>:split<CR>:res -5<CR>:term<CR>i
vim.keymap.set('n', '<C-`>', ':set splitbelow<CR>:split<CR>:res -5<CR>:term<CR>i', nsopts)

-- Open a new instance of st with the cwd
-- nnoremap \t :tabe<CR>:-tabmove<CR>:term sh -c 'st'<CR><C-\><C-N>:q<CR>
-- Open a new terminal tab
vim.keymap.set('n', [[\t]], ':tabe<CR>:term<CR>i', nsopts)

-- ==================== Tab management ====================
-- Create a new tab with tu
vim.keymap.set('n', 'tu', ':tabe<CR>', nsopts)
vim.keymap.set('n', 'tU', ':tab split<CR>', nsopts)
-- Move around tabs with tn and ti
vim.keymap.set('n', 'tn', ':-tabnext<CR>', nsopts)
vim.keymap.set('n', 'ti', ':+tabnext<CR>', nsopts)
-- Move the tabs with tN and tI
vim.keymap.set('n', 'tN', ':-tabmove<CR>', nsopts)
vim.keymap.set('n', 'tI', ':+tabmove<CR>', nsopts)

-- Tab switch
vim.cmd(':nn <Leader>1 1gt')
vim.cmd(':nn <Leader>2 2gt')
vim.cmd(':nn <Leader>3 3gt')
vim.cmd(':nn <Leader>4 4gt')
vim.cmd(':nn <Leader>5 5gt')
vim.cmd(':nn <Leader>6 6gt')
vim.cmd(':nn <Leader>7 7gt')
vim.cmd(':nn <Leader>8 8gt')
vim.cmd(':nn <Leader>9 9gt')
vim.cmd(':nn <Leader>0 :tablast<CR>')

-- Close tab
vim.keymap.set('n', 'tw', ':tabclose<CR>', nsopts)

-- Close all other tabs
vim.keymap.set('n', 'to', ':tabonly<CR>', nsopts)

-- ==================== Markdown Settings ====================
-- Snippets
-- source $HOME/.config/nvim/file-snippets.vim
-- auto spell
vim.cmd('autocmd BufRead,BufNewFile *.md setlocal spell')

-- ==================== Other useful stuff ====================
-- Press space twice to jump to the next '<++>' and edit it
vim.keymap.set('n', '<LEADER><LEADER>', '<Esc>/<++><CR>:nohlsearch<CR>c4l', nsopts)

-- Spelling Check with <space>sc
vim.keymap.set('n', '<LEADER>sc', ':set spell!<CR>', nsopts)

-- adjust current line to center of screen
vim.keymap.set('n', '<C-c>', 'zz', nsopts)

-- Auto change directory to current dir
vim.cmd('autocmd BufEnter * silent! lcd %:p:h')

-- Call figlet
vim.keymap.set('n', 'tx', ':r !figlet', nsopts)

-- Set wrap
vim.keymap.set('n', '<LEADER>sw', ':set wrap<CR>', nsopts)

print(vim.loop.os_uname().sysname)
