" ============ airline ============
let g:airline_theme = 'material'
" let g:airline#extensions#tabline#enabled = 1

" ============ color theme ============
let g:material_theme_style = 'ocean-community'
" let g:material_theme_style = 'default' | 'palenight' | 'ocean' | 'lighter' | 'darker' | 'default-community' | 'palenight-community' | 'ocean-community' | 'lighter-community' | 'darker-community'
color material

" ============ devicons ============
let g:webdevicons_enable_airline_tabline = 1
let g:webdevicons_enable_airline_statusline = 1
let g:webdevicons_enable_nerdtree = 1
let g:webdevicons_conceal_nerdtree_brackets = 1

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
autocmd FileType go nnoremap <LEADER>dR :call vimspector#Reset()<CR>
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
	echo "launch project"
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
	echo "launch file"
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
	echo "lanuch test: [".funcName."]"
	silent call vimspector#LaunchWithConfigurations({
				\	 "Launch Test": {
				\	 	"adapter": "vscode-go",
				\	 	"filetypes": ["go"],
				\	 	"configuration": {
				\	 		"request": "launch",
				\	 		"program": "${fileDirname}",
				\	 		"mode": "test",
				\	 		"dlvToolPath": "$HOME/go/bin/dlv",
				\	 		"args": ["-test.v", "-test.run", funcName]
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

