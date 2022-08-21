" ============ coc ============
" coc-marketplace
let g:coc_global_extensions = [
	\ 'coc-json',
	\ 'coc-yaml',
	\ 'coc-vimlsp',
	\ 'coc-docker',
	\ 'coc-explorer',
	\ 'coc-gitignore',
	\ 'coc-html',
	\ 'coc-prettier',
	\ 'coc-snippets',
	\ 'coc-lists',
	\ 'coc-yank',
	\ 'coc-syntax',
	\ 'coc-tasks',
	\ 'coc-translator'
\ ]
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

inoremap <silent><expr> <c-o> coc#refresh()

nnoremap <c-c> :CocCommand<CR>

" Use `-` and `=` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nnoremap <silent><nowait> <LEADER>dd :CocList diagnostics<CR>
nmap <silent> <LEADER>- <Plug>(coc-diagnostic-prev)
nmap <silent> <LEADER>= <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gD :tab sp<CR><Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> <LEADER>cw <Plug>(coc-rename)

" Use K to show documentation in preview window.
nnoremap <silent> <LEADER>h :call ShowDocumentation()<CR>
function! ShowDocumentation()
  call CocActionAsync('highlight')
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Format selected code
" xmap <LEADER>f <Plug>(coc-format-selected)
" nmap <LEADER>f <Plug>(coc-format-selected)

" Text Objects
xmap kf <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap kf <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)
xmap kc <Plug>(coc-classobj-i)
omap kc <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" coc-translator
nmap ts <Plug>(coc-translator-p)

" codeaction
xmap <LEADER>a  <Plug>(coc-codeaction-selected)
nmap <LEADER>aw  <Plug>(coc-codeaction-selected)w

" coc-snippets
imap <C-l> <Plug>(coc-snippets-expand)
vmap <C-e> <Plug>(coc-snippets-select)
let g:coc_snippet_next = '<c-e>'
let g:coc_snippet_prev = '<c-n>'
imap <C-e> <Plug>(coc-snippets-expand-jump)

" nmap <silent> tt :CocCommand explorer<CR>
nmap <silent> tt :CocCommand explorer --preset simplifyFloating<CR>

" List all presets
nmap <space>el <Cmd>CocList explPresets<CR>

" List all yank history
nnoremap <silent> <space>y :<C-u>CocList -A --normal yank<cr>
