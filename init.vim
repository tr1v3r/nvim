" =========================== vimrc ===========================
"  ____  _       _____       __     _____ __  __ ____   ____
" |  _ \/ |_   _|___ / _ __  \ \   / /_ _|  \/  |  _ \ / ___|
" | |_) | \ \ / / |_ \| '__|  \ \ / / | || |\/| | |_) | |
" |  _ <| |\ V / ___) | |      \ V /  | || |  | |  _ <| |___
" |_| \_\_| \_/ |____/|_|       \_/  |___|_|  |_|_| \_\\____|
"
" Author: @riverchu(R1v3r)
"
" ==================== Start up check ====================
if empty(glob($HOME.'/.config/nvim/autoload/plug.vim'))
	silent !curl -fLo $HOME/.config/nvim/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

let g:nvim_plugins_installation_completed=1

" Check if in vscode
" https://github.com/vscode-neovim/vscode-neovim
if exists('g:vscode')
    " VSCode extension
else
    " ordinary Neovim
endif

" 设置 vimrc 修改保存后立刻生效，不用在重新打开
" 建议配置完成后将这个关闭
" autocmd BufWritePost $MYVIMRC source $MYVIMRC

source $HOME/.config/nvim/setting.vim
source $HOME/.config/nvim/keymap.vim
source $HOME/.config/nvim/lang.vim
source $HOME/.config/nvim/plug.vim
source $HOME/.config/nvim/plug-config.vim
source $HOME/.config/nvim/coc.vim

let device_specificed = 1
if empty(glob($HOME.'/.config/nvim/_device.vim'))
	echo 'device vim not found'
el
	source $HOME/.config/nvim/_device.vim
endif
