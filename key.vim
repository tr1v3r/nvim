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
