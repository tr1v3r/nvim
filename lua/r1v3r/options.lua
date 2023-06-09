-- ================ Settings ================

vim.o.termguicolors = true
vim.o.t_Co = 256 -- vim-monokai now only support 256 colours in terminal.

-- Line numbers
vim.wo.number = true
vim.wo.relativenumber = true
-- Show command in status line
vim.o.showcmd = true
-- Enable wildmenu
vim.o.wildmenu = true
-- Enable reading configuration from current directory
vim.o.exrc = true
-- Enable secure mode
vim.o.secure = true
-- Use spaces instead of tabs
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
-- Enable autoindent
vim.o.autoindent = true
-- Disable indent expression
vim.o.indentexpr = ''
-- Show whitespace characters
vim.wo.list = true
vim.o.listchars = 'tab:| ,trail:☒'
-- Set the number of lines to keep above and below the cursor in scroll off
vim.o.scrolloff = 4
-- Disable the time delay for key codes
vim.o.ttimeoutlen = 0
vim.o.timeout = false
-- Set view options for saving and restoring folds, slash search, Unix line endings
vim.o.viewoptions = 'cursor,folds,slash,unix'
-- Highlight current line
vim.wo.cursorline = true
-- Enable line wrapping
vim.wo.wrap = true
-- Disable text width
vim.o.tw = 0
-- Set fold method to syntax
vim.o.foldmethod = 'syntax'
-- Set fold level to maximum
vim.o.foldlevel = 99
-- Enable folding
vim.o.foldenable = true
-- Disable automatic formatting for comments
vim.o.formatoptions = vim.o.formatoptions:gsub('tc', '')
-- Split windows to the right and below
vim.o.splitright = true
vim.o.splitbelow = true
-- Hide mode from status line
vim.o.showmode = false
-- Enable search highlighting
vim.o.hlsearch = true
-- Enable incremental search
vim.o.incsearch = true
-- Ignore case in search unless an uppercase character is used
vim.o.ignorecase = true
vim.o.smartcase = true
-- Shorten error messages
vim.o.shortmess = vim.o.shortmess .. 'flnrwx'
-- Open command-line window in split mode
vim.o.inccommand = 'split'
-- Set completion options
vim.o.completeopt = 'noinsert,longest,menuone,noselect,preview'
-- Enable lazy redraw
vim.o.lazyredraw = true
-- Use visual bell instead of beeping sound
vim.o.visualbell = true
-- Highlight a column at a specific width
vim.wo.colorcolumn = '120'
-- Set the time interval for writing swap and backup files
vim.o.updatetime = 100
-- Enable blockwise virtual editing
vim.o.virtualedit = 'block'
-- Automatically change the current directory to the directory of the current file
vim.o.autochdir = true
-- Automatically write all buffers when executing certain commands
vim.o.autowriteall = true
-- vim.o.signcolumn = 'nubmer'

-- Set backup and undo directories
-- vim.cmd([[silent !mkdir -p $HOME/.cache/nvim/backup]])
-- vim.cmd([[silent !mkdir -p $HOME/.cache/nvim/undo]])
-- vim.o.backupdir = '$HOME/.cache/nvim/backup,.'
-- vim.o.directory = '$HOME/.cache/nvim/backup,.'

-- ================ Autocmd ================

-- transparent bg
vim.cmd([[autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE]])

-- Syntax highlighting
vim.cmd('syntax on')

-- Jump to last cursor position when opening a file
vim.cmd([[au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif]])

-- Save file on TextChanged and InsertLeave events
-- vim.cmd([[au TextChanged,InsertLeave <buffer> silent write]])

-- Disable search highlighting after executing a search
vim.cmd([[exec "nohlsearch"]])

-- Auto change directory to current dir
vim.cmd('autocmd BufEnter * silent! lcd %:p:h')

-- ==================== Markdown Settings ====================
-- Snippets
-- source $HOME/.config/nvim/file-snippets.vim
-- auto spell
vim.cmd('autocmd BufRead,BufNewFile *.md setlocal spell')
