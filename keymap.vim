" =============== Basic Key Mapping ================ 
let mapleader=" "

" Undo
noremap l u
" Insert Key
noremap k i
noremap K I
" Copy to system clipboard
vnoremap Y "+y
" Find pair
noremap ,. %
" Search
noremap <LEADER><CR> :nohlsearch<CR>
" Adjacent duplicate words
noremap <LEADER>dw /\(\<\w\+\>\)\_s*\1
" Find and replace
noremap \s :%s//g<left><left>
" Find and delete (line)
noremap \d :g//d<left><left>
" Space to Tab
nnoremap <LEADER>tt :%s/    /\t/g
vnoremap <LEADER>tt :s/    /\t/g
" Folding
noremap <silent> <LEADER>o za

noremap s <nop>

noremap = nzz
noremap - Nzz

nnoremap S :w<CR>
nnoremap Q :quitall<CR>
"map R :source $MYVIMRC<CR>

noremap ; :
noremap ` ~

" ==================== Cursor Movement ====================
" New cursor movement (the default arrow keys are used for resizing windows)
"     ^
"     u
" < n   i >
"     e
"     v
noremap <silent> n h
noremap <silent> e j
noremap <silent> u k
noremap <silent> i l
noremap <silent> gu gk
noremap <silent> ge gj
noremap <silent> \v v$h

" scroll
noremap <silent> U 5k
noremap <silent> E 5j
" go to start/end of the line
noremap <silent> N 0
noremap <silent> I $
" fast move
noremap W 5w
noremap B 5b
" move up/down the view port without moving the cursor
noremap <C-U> 5<C-y>
noremap <C-E> 5<C-e>

noremap h e

" Custom cursor movement
source $HOME/.config/nvim/cursor.vim


" ==================== Insert Mode Cursor Movement ====================
inoremap <C-a> <ESC>A

" ==================== Command Mode Cursor Movement ====================
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <M-b> <S-Left>
cnoremap <M-w> <S-Right>

" ==================== Window management ====================
noremap <LEADER>w <C-w>w
noremap <LEADER>u <C-w>k
noremap <LEADER>e <C-w>j
noremap <LEADER>n <C-w>h
noremap <LEADER>i <C-w>l

" Close all other windows
noremap tq <C-w>o
" Close all other tabs
noremap to :tabonly<CR>

" Split the screens to up/down/left/right
noremap su :set nosplitbelow<CR>:split<CR>:set splitbelow<CR>
noremap se :set splitbelow<CR>:split<CR>
noremap sn :set nosplitright<CR>:vsplit<CR>:set splitright<CR>
noremap si :set splitright<CR>:vsplit<CR>

" Resize window
noremap <silent> <up> :res +5<CR>
noremap <silent> <down> :res -5<CR>
noremap <silent> <left> :vertical resize-5<CR>
noremap <silent> <right> :vertical resize+5<CR>

" Place the two screens up and down
noremap sh <C-w>t<C-w>K
" Place the two screens side by side
noremap sv <C-w>t<C-w>H
" Rotate screens
noremap srh <C-w>b<C-w>K
noremap srv <C-w>b<C-w>H
" Press <SPACE> + q to close the window below the current window
noremap <LEADER>q <C-w>j:q<CR>

" Opening a terminal window
noremap <LEADER>/ :set splitbelow<CR>:split<CR>:res -5<CR>:term<CR>i

" Open a new instance of st with the cwd
" nnoremap \t :tabe<CR>:-tabmove<CR>:term sh -c 'st'<CR><C-\><C-N>:q<CR>
" Open a new terminal tab
nnoremap \t :tabe<CR>:term<CR>i

" ==================== Tab management ====================
" Create a new tab with tu
noremap tu :tabe<CR>
noremap tU :tab split<CR>
" Move around tabs with tn and ti
noremap tn :-tabnext<CR>
noremap ti :+tabnext<CR>
" Move the tabs with tN and tI
noremap tN :-tabmove<CR>
noremap tI :+tabmove<CR>

" Tab switch
:nn <Leader>1 1gt
:nn <Leader>2 2gt
:nn <Leader>3 3gt
:nn <Leader>4 4gt
:nn <Leader>5 5gt
:nn <Leader>6 6gt
:nn <Leader>7 7gt
:nn <Leader>8 8gt
:nn <Leader>9 9gt
:nn <Leader>0 :tablast<CR>

" Close tab
noremap tw :tabclose<CR>

" ==================== Markdown Settings ====================
" Snippets
source $HOME/.config/nvim/file-snippets.vim
" auto spell
autocmd BufRead,BufNewFile *.md setlocal spell

" ==================== Other useful stuff ====================
" Press space twice to jump to the next '<++>' and edit it
noremap <LEADER><LEADER> <Esc>/<++><CR>:nohlsearch<CR>c4l

" Spelling Check with <space>sc
noremap <LEADER>sc :set spell!<CR>

" adjust current line to center of screen
noremap <C-c> zz

" Auto change directory to current dir
autocmd BufEnter * silent! lcd %:p:h

" Call figlet
noremap tx :r !figlet

" Set wrap
noremap <LEADER>sw :set wrap<CR>
