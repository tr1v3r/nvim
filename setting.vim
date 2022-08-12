" ================ Settings ================
set termguicolors
set t_Co=256  " vim-monokai now only support 256 colours in terminal.
autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE " transparent bg

syntax on
set number
set relativenumber
set showcmd
set wildmenu
set exrc
set secure
set noexpandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set indentexpr=
set list
set listchars=tab:\|\ ,trail:<
set scrolloff=4
set ttimeoutlen=0
set notimeout
set viewoptions=cursor,folds,slash,unix
set cursorline
set wrap
set tw=0
set foldmethod=syntax
set foldlevel=99
set foldenable
set formatoptions-=tc
set splitright
set splitbelow
set noshowmode
set hlsearch
set incsearch
set ignorecase
set smartcase
set shortmess+=flnrwx
set inccommand=split
set completeopt=noinsert,longest,menuone,noselect,preview
set lazyredraw
set visualbell
set colorcolumn=120
set updatetime=100
set virtualedit=block
" set signcolumn=number

let &t_ut=''
silent !mkdir -p $HOME/.config/nvim/tmp/backup
silent !mkdir -p $HOME/.config/nvim/tmp/undo
set backupdir=$HOME/.config/nvim/tmp/backup,.
set directory=$HOME/.config/nvim/tmp/backup,.

au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

exec "nohlsearch"

