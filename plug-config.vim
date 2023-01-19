" ============ airline ============
let g:airline_theme = 'material'

" symbols
if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif

let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.dirty= '⚡'

" extensions
" let g:airline_extensions = ['branch', 'tabline']

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#buffer_nr_show = 0
" let g:airline#extensions#tabline#buffer_nr_format = '%s: '
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#show_close_button = 0
" let g:airline#extensions#tabline#show_tab_nr = 0
let g:airline#extensions#tabline#ctrlspace_show_tab_nr = 0
" let g:airline#extensions#tabline#tab_nr_type = 1 " tab number

" https://github.com/vim-airline/vim-airline/issues/2206
" let g:airline#extensions#tabline#tabnr_formatter = 'AirLineTabNrFormatter'
" func AirLineTabNrFormatter(tab_nr_type, nr)
  " let nr = a:nr[0]
  " let spc = g:airline_symbols.space
  " if (len(tabpagebuflist(nr)) > 1)
    " return spc. nr. ':[%{tabpagewinnr('.nr.')}/%{len(tabpagebuflist('.nr.'))}]'
  " else
    " return spc. nr. ":"
  " endif
" endfunc
"
" let g:airline#extensions#tabline#tabtitle_formatter = 'AirLineTabTitleFormatter'
" func AirLineTabTitleFormatter(n)
  " let buflist = tabpagebuflist(a:n)
  " let winnr = tabpagewinnr(a:n)
  " let bufnr = buflist[winnr - 1]
  " let winid = win_getid(winnr, a:n)
  " let title = bufname(bufnr)
"
  " if empty(title)
    " if getqflist({'qfbufnr' : 0}).qfbufnr == bufnr
      " let title = '[Quickfix List]'
    " elseif winid && getloclist(winid, {'qfbufnr' : 0}).qfbufnr == bufnr
      " let title = '[Location List]'
    " else
      " let title = '[No Name]'
    " endif
  " endif
"
  " return title
" endfunc

let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#branch#empty_message = ''
let g:airline#extensions#branch#displayed_head_limit = 12
let g:airline#extensions#branch#format = 2

" ============ xtabline ============
let g:xtabline_lazy = 1
let g:xtabline_settings.current_tab_paths = 1

" ============ color theme ============
let g:material_theme_style = 'ocean-community'
" let g:material_theme_style = 'default' | 'palenight' | 'ocean' | 'lighter' | 'darker' | 'default-community' | 'palenight-community' | 'ocean-community' | 'lighter-community' | 'darker-community'
color material

" ============ devicons ============
let g:webdevicons_enable_airline_tabline = 1
let g:webdevicons_enable_airline_statusline = 1
let g:webdevicons_enable_nerdtree = 1
let g:webdevicons_conceal_nerdtree_brackets = 1

" ==================== wildfire ====================
map <c-b> <Plug>(wildfire-quick-select)
let g:wildfire_objects = {
    \ "*" : ["i'", 'i"', "i)", "i]", "i}", "it"],
    \ "html,xml" : ["at", "it"],
\ }

" ==================== lightspeed ====================
nmap <expr> f reg_recording() . reg_executing() == "" ? "<Plug>Lightspeed_f" : "f"
nmap <expr> F reg_recording() . reg_executing() == "" ? "<Plug>Lightspeed_F" : "F"
nmap <expr> t reg_recording() . reg_executing() == "" ? "<Plug>Lightspeed_t" : "t"
nmap <expr> T reg_recording() . reg_executing() == "" ? "<Plug>Lightspeed_T" : "T"
" autocmd BufEnter * map <buffer> <nowait> { <Plug>Lightspeed_S
map <nowait> " <Plug>Lightspeed_omni_s
if g:nvim_plugins_installation_completed == 1
lua <<EOF
require'lightspeed'.setup {
  ignore_case = true,
  -- exit_after_idle_msecs = { unlabeled = 1000, labeled = nil },
  -- --- s/x ---
  -- jump_to_unique_chars = { safety_timeout = 400 },
  -- match_only_the_start_of_same_char_seqs = true,
  force_beacons_into_match_width = true,
  -- -- Display characters in a custom way in the highlighted matches.
  -- substitute_chars = { ['\r'] = '¬', },
  -- -- Leaving the appropriate list empty effectively disables "smart" mode,
  -- -- and forces auto-jump to be on or off.
  safe_labels= {"a", "r", "s", "t", "n", "e", "i", "o", "w", "f", "u", "y", "x", 'c', "v", "k", "m"},
  -- labels = {},
  special_keys = {
    next_match_group = '<space>',
    prev_match_group = '<tab>',
  },
}
EOF
endif

" ==================== vim-visual-multi ====================
"let g:VM_theme             = 'iceblue'
"let g:VM_default_mappings = 0
let g:VM_leader                     = {'default': ',', 'visual': ',', 'buffer': ','}
let g:VM_maps                       = {}
let g:VM_custom_motions             = {'n': 'h', 'i': 'l', 'u': 'k', 'e': 'j', 'N': '0', 'I': '$', 'h': 'e'}
let g:VM_maps['i']				  = 'k'
let g:VM_maps['I']				  = 'K'
let g:VM_maps['Find Under']		 = '<C-k>'
let g:VM_maps['Find subword under'] = '<C-k>'
let g:VM_maps['Find Next']          = ''
let g:VM_maps['Find Prev']          = ''
let g:VM_maps['Remove Region']      = 'q'
let g:VM_maps['Skip Region']        = '<c-n>'
let g:VM_maps["Undo"]               = 'l'
let g:VM_maps["Redo"]               = '<C-r>'
" for MacOS
let g:VM_maps["Select Cursor Down"] = '<A-Down>'
let g:VM_maps["Select Cursor Up"]   = '<A-Up>'

" ==================== vim-snippets ====================
let g:snips_author = '<++>'

" " ============ nerdtree ============
" " 忽略以下文件的显示
" let NERDTreeIgnore=['\.pyc','\~$','\.swp']
" let g:NERDTreeGitStatusIndicatorMapCustom = {
"     \ "Modified"  : "✹",
"     \ "Staged"    : "✚",
"     \ "Untracked" : "✭",
"     \ "Renamed"   : "➜",
"     \ "Unmerged"  : "═",
"     \ "Deleted"   : "✖",
"     \ "Dirty"     : "✗",
"     \ "Clean"     : "✔︎",
"     \ 'Ignored'   : '☒',
"     \ "Unknown"   : "?"
"     \ }
" let g:NERDTreeGitStatusUseNerdFonts = 1
" 
" " let g:NERDTreeWinSize = 33
" " let g:NERDTreeShowLineNumbers = 1
" 
" " Start NERDTree and put the cursor back in the other window.
" " autocmd VimEnter * NERDTree | wincmd p
" 
" " Exit Vim if NERDTree is the only window remaining in the only tab.
" autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" 
" " Open the existing NERDTree on each new tab.
" autocmd BufWinEnter * if tabpagenr('$') != 1 && getcmdwintype() == '' | silent NERDTreeMirror | endif
" 
" noremap tt :NERDTreeToggle<CR>
" let NERDTreeMapOpenExpl = ""
" let NERDTreeMapUpdir = "N"
" let NERDTreeMapUpdirKeepOpen = ""
" let NERDTreeMapOpenSplit = "gs"
" " let NERDTreeMapPreviewSplit = ""
" let NERDTreeMapOpenVSplit = "vs"
" " let NERDTreeMapPreviewVSplit = ""
" let NERDTreeMapActivateNode = "i"
" let NERDTreeMapPreview = "I"
" let NERDTreeMapOpenInTab = "o"
" let NERDTreeMapCloseDir = "n"
" let NERDTreeMapChangeRoot = "y"

" ==================== GitGutter ====================
" let g:gitgutter_signs = 0
let g:gitgutter_sign_allow_clobber = 0
let g:gitgutter_map_keys = 0
let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_preview_win_floating = 1
let g:gitgutter_sign_added = '▎'
let g:gitgutter_sign_modified = '░'
let g:gitgutter_sign_removed = '▏'
let g:gitgutter_sign_removed_first_line = '▔'
let g:gitgutter_sign_modified_removed = '▒'
nnoremap <LEADER>gf :GitGutterFold<CR>
nnoremap H :GitGutterPreviewHunk<CR>
nnoremap <LEADER>g- :GitGutterPrevHunk<CR>
nnoremap <LEADER>g= :GitGutterNextHunk<CR>

" ==================== lazygit.nvim ====================
noremap <c-g> :LazyGit<CR>
let g:lazygit_floating_window_winblend = 0 " transparency of floating window
let g:lazygit_floating_window_scaling_factor = 1.0 " scaling factor for floating window
let g:lazygit_floating_window_corner_chars = ['╭', '╮', '╰', '╯'] " customize lazygit popup window corner characters
let g:lazygit_use_neovim_remote = 1 " for neovim-remote support

" ==================== vimspector ====================
let g:vimspector_enable_mappings = 'HUMAN'
sign define vimspectorBP text=⛔ texthl=Normal
sign define vimspectorBPDisabled text=⭕ texthl=Normal
sign define vimspectorPC text=👉 texthl=SpellBad
function! s:read_template_into_buffer(template)
	" has to be a function to avoid the extra space fzf#run insers otherwise
	execute '0r ~/.config/nvim/vimspector_sample_json/'.a:template
endfunction
command! -bang -nargs=* LoadVimSpectorJsonTemplate call fzf#run({
			\   'source': 'ls -1 ~/.config/nvim/vimspector_sample_json',
			\   'down': 20,
			\   'sink': function('<sid>read_template_into_buffer')
			\ })

autocmd FileType go noremap <LEADER>vs :tabe .vimspector.json<CR>:LoadVimSpectorJsonTemplate<CR>
autocmd FileType go nnoremap <LEADER>dr :call vimspector#Reset()<CR>
autocmd FileType go nnoremap <LEADER>dR :call vimspector#Restart()<CR>
autocmd FileType go nnoremap <LEADER>dC :call vimspector#ClearBreakpoints()<CR>
autocmd FileType go nnoremap <LEADER>dL :call vimspector#ListBreakpoints()<CR>
autocmd FileType go nnoremap <LEADER>dw :call AddToWatch()<CR>
autocmd FileType go nnoremap <LEADER>dp :call LaunchProject()<CR>
autocmd FileType go nnoremap <LEADER>df :call LaunchFile()<CR>
autocmd FileType go nnoremap <LEADER>du :call DebugFunc()<CR>

" mnemonic 'di' = 'debug inspect' (pick your own, if you prefer!)

" for normal mode - the word under the cursor
autocmd FileType go nmap <Leader>di <Plug>VimspectorBalloonEval
" for visual mode, the visually selected text
autocmd FileType go xmap <Leader>direferences <Plug>VimspectorBalloonEval

func! AddToWatch()
	let expr = expand("<cexpr>")
	call vimspector#AddWatch(expr)
endfunc
" let go:vimspector_base_dir = expand('$HOME/.config/vimspector-config')

func! LaunchProject()
	echo "Launch project"
	call vimspector#LaunchWithConfigurations({
				\	"Launch Project": {
				\		"adapter": "vscode-go",
				\		"filetypes": ["go"],
				\		"configuration": {
				\			"request": "launch",
				\			"program": "${workspaceRoot}",
				\			"mode": "debug",
				\			"dlvToolPath": "$HOME/go/bin/dlv",
				\			"dlvFlags": ["--check-go-version=false"]
				\		}
				\	}
				\ })
endfunc

func! LaunchFile()
	echo "Launch file"
	call vimspector#LaunchWithConfigurations({
				\	"Launch File": {
				\		"adapter": "vscode-go",
				\		"filetypes": ["go"],
				\		"configuration": {
				\			"request": "launch",
				\			"program": "${fileDirname}",
				\			"mode": "debug",
				\			"dlvToolPath": "$HOME/go/bin/dlv"
				\		}
				\	}
				\ })
endfunc

func! DebugFunc()
	" let funcName = CocAction("getCurrentFunctionSymbol")
	" let funcName = trim(split(CocAction("getCurrentFunctionSymbol"),' ')[1])
	" let funcName = trim(CocAction("getCurrentFunctionSymbol")[3:])
	let funcName = trim(CocAction("getCurrentFunctionSymbol"), "ƒ ")
	if funcName != ""
		let funcName = '^'.funcName.'$'
	endif
	echo "Lanuch test: ".funcName
	silent call vimspector#LaunchWithConfigurations({
				\	 "Launch Test": {
				\	 	"adapter": "vscode-go",
				\	 	"filetypes": ["go"],
				\	 	"configuration": {
				\	 		"request": "launch",
				\	 		"program": "${fileDirname}",
				\	 		"mode": "test",
				\	 		"dlvToolPath": "$HOME/go/bin/dlv",
				\	 		"args": ["-test.v", "-test.count", 1, "-test.run", funcName]
				\	 	}
				\	 }
				\ })
	" call from file with settings
	" call vimspector#LaunchWithSettings(#{ configuration: 'Launch Test', UnitTestFunc: funcName })
endfunc

" "args": [ "*${CommandLineArgs}" ]

" ============ vim-go ============
autocmd FileType go nmap <leader>b  <Plug>(go-build)
autocmd FileType go nmap <leader>r  <Plug>(go-run)
" autocmd FileType go autocmd InsertLeave * GoFmt

let g:go_fmt_command = 'goimports'
let g:go_list_type = "quickfix"
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

let g:go_highlight_array_whitespace_error = 1
let g:go_highlight_chan_whitespace_error = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_variable_declarations = 1
let g:go_highlight_variable_assignments = 1
let g:go_doc_keywordprg_enabled = 0

let g:go_debug_windows = {
	\ 'vars':       'rightbelow 30vnew',
	\ 'goroutines': '10new',
	\ 'stack':      '20new',
	\ 'out':        'bot 5new',
\ }
let g:go_debug_preserve_layout = 1
let g:go_debug_log_output = ''

let g:go_metalinter_command = "golangci-lint"
" let g:go_metalinter_autosave = 1

" ==================== tagbar ====================
" Toggle
noremap <LEADER>T :TagbarToggle<CR>

" ctags
" git clone https://github.com/universal-ctags/ctags.git
" cd ctags
" ./autogen.sh
" ./configure --prefix=/where/you/want # defaults to /usr/local
" make
" make install # may require extra privileges depending on where to install

" gotags
" go install github.com/jstemmer/gotags@latest
let g:tagbar_type_go = {
	\ 'ctagstype' : 'go',
	\ 'kinds'     : [
		\ 'p:package',
		\ 'i:imports:1',
		\ 'c:constants',
		\ 'v:variables',
		\ 't:types',
		\ 'n:interfaces',
		\ 'w:fields',
		\ 'e:embedded',
		\ 'm:methods',
		\ 'r:constructor',
		\ 'f:functions'
	\ ],
	\ 'sro' : '.',
	\ 'kind2scope' : {
		\ 't' : 'ctype',
		\ 'n' : 'ntype'
	\ },
	\ 'scope2kind' : {
		\ 'ctype' : 't',
		\ 'ntype' : 'n'
	\ },
	\ 'ctagsbin'  : 'gotags',
	\ 'ctagsargs' : '-sort -silent'
\ }

" ==================== goyo ====================
map <LEADER>gy :Goyo<CR>

" ==================== FZF ====================
let g:fzf_preview_window = 'right:40%'
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

function! s:list_buffers()
  redir => list
  silent ls
  redir END
  return split(list, "\n")
endfunction

function! s:delete_buffers(lines)
  execute 'bwipeout' join(map(a:lines, {_, line -> split(line)[0]}))
endfunction

command! BD call fzf#run(fzf#wrap({
  \ 'source': s:list_buffers(),
  \ 'sink*': { lines -> s:delete_buffers(lines) },
  \ 'options': '--multi --reverse --bind ctrl-a:select-all+accept'
\ }))

noremap <c-d> :BD<CR>

let g:fzf_layout = { 'window': { 'width': 0.95, 'height': 0.95 } }

" ==================== fzf-gitignore ====================
noremap <LEADER>gi :FzfGitignore<CR>

" ==================== fzf-lua ====================
noremap <silent> <C-p> :FzfLua files<CR>
noremap <silent> <C-f> :Rg<CR>
noremap <silent> <C-h> :FzfLua oldfiles cwd=~<CR>
noremap <silent> <C-q> :FzfLua builtin<CR>
noremap <silent> <C-t> :FzfLua lines<CR>
" noremap <silent> <C-x> :FzfLua resume<CR>
noremap <silent> z= :FzfLua spell_suggest<CR>
noremap <silent> <C-w> :FzfLua buffers<CR>
noremap <leader>; :History:<CR>
augroup fzf_commands
  autocmd!
  autocmd FileType fzf tnoremap <silent> <buffer> <c-j> <down>
  autocmd FileType fzf tnoremap <silent> <buffer> <c-k> <up>
augroup end
if g:nvim_plugins_installation_completed == 1
lua <<EOF
require'fzf-lua'.setup {
	global_resume = true,
	global_resume_query = true,
	winopts = {
		height = 0.95,
		width = 0.95,
		preview = {
			scrollbar = 'float',
		},
		fullscreen = false,
		vertical       = 'down:45%',      -- up|down:size
		horizontal     = 'right:60%',     -- right|left:size
		hidden         = 'nohidden',
		title = true,
	},
	keymap = {
		-- These override the default tables completely
		-- no need to set to `false` to disable a bind
		-- delete or modify is sufficient
		builtin = {
			["<c-f>"]      = "toggle-fullscreen",
			["<c-r>"]      = "toggle-preview-wrap",
			["<c-p>"]      = "toggle-preview",
			["<c-y>"]      = "preview-page-down",
			["<c-l>"]      = "preview-page-up",
			["<S-left>"]   = "preview-page-reset",
		},
		fzf = {
			["esc"]        = "abort",
			["ctrl-h"]     = "unix-line-discard",
			["ctrl-k"]     = "half-page-down",
			["ctrl-b"]     = "half-page-up",
			["ctrl-n"]     = "beginning-of-line",
			["ctrl-a"]     = "end-of-line",
			["alt-a"]      = "toggle-all",
			["f3"]         = "toggle-preview-wrap",
			["f4"]         = "toggle-preview",
			["shift-down"] = "preview-page-down",
			["shift-up"]   = "preview-page-up",
			["ctrl-e"]     = "down",
			["ctrl-u"]     = "up",
		},
	},
  previewers = {
    cat = {
      cmd             = "cat",
      args            = "--number",
    },
    bat = {
      cmd             = "bat",
      args            = "--style=numbers,changes --color always",
      theme           = 'Coldark-Dark', -- bat preview theme (bat --list-themes)
      config          = nil,            -- nil uses $BAT_CONFIG_PATH
    },
    head = {
      cmd             = "head",
      args            = nil,
    },
    git_diff = {
      cmd_deleted     = "git diff --color HEAD --",
      cmd_modified    = "git diff --color HEAD",
      cmd_untracked   = "git diff --color --no-index /dev/null",
      -- pager        = "delta",      -- if you have `delta` installed
    },
    man = {
      cmd             = "man -c %s | col -bx",
    },
    builtin = {
      syntax          = true,         -- preview syntax highlight?
      syntax_limit_l  = 0,            -- syntax limit (lines), 0=nolimit
      syntax_limit_b  = 1024*1024,    -- syntax limit (bytes), 0=nolimit
    },
  },
  files = {
    -- previewer      = "bat",          -- uncomment to override previewer
                                        -- (name from 'previewers' table)
                                        -- set to 'false' to disable
    prompt            = 'Files❯ ',
    multiprocess      = true,           -- run command in a separate process
    git_icons         = true,           -- show git icons?
    file_icons        = true,           -- show file icons?
    color_icons       = true,           -- colorize file|git icons
    -- executed command priority is 'cmd' (if exists)
    -- otherwise auto-detect prioritizes `fd`:`rg`:`find`
    -- default options are controlled by 'fd|rg|find|_opts'
    -- NOTE: 'find -printf' requires GNU find
    -- cmd            = "find . -type f -printf '%P\n'",
    find_opts         = [[-type f -not -path '*/\.git/*' -printf '%P\n']],
    rg_opts           = "--color=never --files --hidden --follow -g '!.git'",
    fd_opts           = "--color=never --type f --hidden --follow --exclude .git",
  },
  buffers = {
    prompt            = 'Buffers❯ ',
    file_icons        = true,         -- show file icons?
    color_icons       = true,         -- colorize file|git icons
    sort_lastused     = true,         -- sort buffers() by last used
  },
}
EOF
endif

" ==================== any-jump ====================
nnoremap j :AnyJump<CR>
let g:any_jump_window_width_ratio  = 0.8
let g:any_jump_window_height_ratio = 0.9

" ==================== rainbow ====================
let g:rainbow_active = 1

" ==================== nvim-spectre ====================
nnoremap <LEADER>f <cmd>lua require('spectre').open()<CR>i
vnoremap <LEADER>f <cmd>lua require('spectre').open_visual()<CR>i

" ==================== rnvimr ====================
let g:rnvimr_ex_enable = 1
let g:rnvimr_pick_enable = 1
let g:rnvimr_draw_border = 0
" let g:rnvimr_bw_enable = 1
highlight link RnvimrNormal CursorLine
nnoremap <silent> R :RnvimrToggle<CR><C-\><C-n>:RnvimrResize 0<CR>
let g:rnvimr_action = {
            \ '<C-t>': 'NvimEdit tabedit',
            \ '<C-x>': 'NvimEdit split',
            \ '<C-v>': 'NvimEdit vsplit',
            \ 'gw': 'JumpNvimCwd',
            \ 'yw': 'EmitRangerCwd'
            \ }
let g:rnvimr_layout = { 'relative': 'editor',
            \ 'width': &columns,
            \ 'height': &lines,
            \ 'col': 0,
            \ 'row': 0,
            \ 'style': 'minimal' }
" let g:rnvimr_presets = [
" 	\ {'width': 1.0, 'height': 1.0},
" 	\ {'width': 0.8, 'height': 0.8}]

let g:rnvimr_presets = [{'width': 1.0, 'height': 1.0}]

" ==================== Markdown Settings ====================
" auto spell
autocmd BufRead,BufNewFile *.md setlocal spell

" ==================== vim-instant-markdown ====================
" npm -g install instant-markdown-d
" yarn global add instant-markdown-d not recommand
let g:instant_markdown_slow = 0
let g:instant_markdown_autostart = 0
" let g:instant_markdown_open_to_the_world = 1
" let g:instant_markdown_allow_unsafe_content = 1
" let g:instant_markdown_allow_external_content = 0
" let g:instant_markdown_mathjax = 1
let g:instant_markdown_autoscroll = 1

" ==================== Bullets.vim ====================
" let g:bullets_set_mappings = 0
let g:bullets_enabled_file_types = [
			\ 'markdown',
			\ 'text',
			\ 'gitcommit',
			\ 'scratch'
			\]

" ==================== vim-markdown-toc ====================
"let g:vmt_auto_update_on_save = 0
"let g:vmt_dont_insert_fence = 1
let g:vmt_cycle_list_item_markers = 1
let g:vmt_fence_text = 'TOC'
let g:vmt_fence_closing_text = '/TOC'

" ==================== vimtex ====================
" This is necessary for VimTeX to load properly. The "indent" is optional.
" Note that most plugin managers will do this automatically.
filetype plugin indent on

" This enables Vim's and neovim's syntax-related features. Without this, some
" VimTeX features will not work (see ":help vimtex-requirements" for more
" info).
syntax enable

" Viewer options: One may configure the viewer either by specifying a built-in
" viewer method:
" let g:vimtex_view_method = 'zathura'
" for skim
let g:vimtex_view_method = 'skim'
let g:vimtex_view_skim_activate = 1
let g:vimtex_view_skim_sync = 1
let g:vimtex_view_skim_reading_bar = 1
" config for skim to inverse search
" nvim --headless -c "VimtexInverseSearch %line '%file'"

" ======== for MacOS
" $ brew tap zegervdv/zathura
" $ brew install zathura
"
" # plug
" $ brew install zathura-pdf-poppler
" $ mkdir -p $(brew --prefix zathura)/lib/zathura
" $ ln -s $(brew --prefix zathura-pdf-poppler)/libpdf-poppler.dylib $(brew --prefix zathura)/lib/zathura/libpdf-poppler.dylib
"
" # For mupdf:
" $ brew install zathura-pdf-mupdf
" $ mkdir -p $(brew --prefix zathura)/lib/zathura
" $ ln -s $(brew --prefix zathura-pdf-mupdf)/libpdf-mupdf.dylib $(brew --prefix zathura)/lib/zathura/libpdf-mupdf.dylib

" Or with a generic interface:
" let g:vimtex_view_general_viewer = 'zathura'
" let g:vimtex_view_general_viewer = 'okular'
" let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
" for linux: https://okular.kde.org/zh-cn/build-it/
" for MacOS https://gist.github.com/7468696e6b/ec8fa5d6cdb4e80633b9df95869b70c0
" for MacOS https://binary-factory.kde.org/job/Okular_Release_macos/
"
" skim for MacOS https://sspai.com/post/64080
" let g:vimtex_view_general_viewer = '/Applications/Skim.app/Contents/SharedSupport/displayline'
" let g:vimtex_view_general_options = '-r @line @pdf @tex'

" VimTeX uses latexmk as the default compiler backend. If you use it, which is
" strongly recommended, you probably don't need to configure anything. If you
" want another compiler backend, you can change it as follows. The list of
" supported backends and further explanation is provided in the documentation,
" see ":help vimtex-compiler".
let g:vimtex_compiler_method = 'latexmk'
" use MacTex for MacOS: https://www.tug.org/mactex/
" or install slim version Basictex: brew install basictex

" Most VimTeX mappings rely on localleader and this can be changed with the
" following line. The default is usually fine and is the symbol "\".
let maplocalleader = " "

" ==================== nerdcommenter ====================
" Create default mappings
let g:NERDCreateDefaultMappings = 1

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_go = 1

" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = {
    \	'c': { 'left': '/**','right': '*/' },
    \	'go': { 'left': '//' },
\ }

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Enable NERDCommenterToggle to check all selected lines is commented or not 
let g:NERDToggleCheckAllLines = 1
