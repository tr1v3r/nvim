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

-- Set backup and undo directories
-- vim.cmd([[silent !mkdir -p $HOME/.cache/nvim/backup]])
-- vim.cmd([[silent !mkdir -p $HOME/.cache/nvim/undo]])
-- vim.o.backupdir = '$HOME/.cache/nvim/backup,.'
-- vim.o.directory = '$HOME/.cache/nvim/backup,.'