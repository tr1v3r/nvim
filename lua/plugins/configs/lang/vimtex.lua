return function()
	-- This is necessary for VimTeX to load properly. The "indent" is optional.
	-- Note that most plugin managers will do this automatically.
	-- vim.cmd([[filetype plugin indent on]]) not necessary, set default

	-- This enables Vim's and neovim's syntax-related features. Without this, some
	-- VimTeX features will not work (see ":help vimtex-requirements" for more
	-- info).
	-- vim.cmd([[syntax enable]])

	-- Viewer options: One may configure the viewer either by specifying a built-in
	-- viewer method:
	-- let g:vimtex_view_method = 'zathura'

	if require("r1v3r.global").is_mac then
		-- for skim
		vim.g.vimtex_view_method = "skim"
		vim.g.vimtex_view_skim_activate = 1
		vim.g.vimtex_view_skim_sync = 1
		vim.g.vimtex_view_skim_reading_bar = 1
	end

	-- config for skim to inverse search
	-- nvim --headless -c "VimtexInverseSearch %line '%file'"

	-- ======== for MacOS
	-- $ brew tap zegervdv/zathura
	-- $ brew install zathura
	--
	-- # plug
	-- $ brew install zathura-pdf-poppler
	-- $ mkdir -p $(brew --prefix zathura)/lib/zathura
	-- $ ln -s $(brew --prefix zathura-pdf-poppler)/libpdf-poppler.dylib $(brew --prefix zathura)/lib/zathura/libpdf-poppler.dylib
	--
	-- # For mupdf:
	-- $ brew install zathura-pdf-mupdf
	-- $ mkdir -p $(brew --prefix zathura)/lib/zathura
	-- $ ln -s $(brew --prefix zathura-pdf-mupdf)/libpdf-mupdf.dylib $(brew --prefix zathura)/lib/zathura/libpdf-mupdf.dylib

	-- Or with a generic interface:
	-- let g:vimtex_view_general_viewer = 'zathura'
	-- let g:vimtex_view_general_viewer = 'okular'
	-- let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
	-- for linux: https://okular.kde.org/zh-cn/build-it/
	-- for MacOS https://gist.github.com/7468696e6b/ec8fa5d6cdb4e80633b9df95869b70c0
	-- for MacOS https://binary-factory.kde.org/job/Okular_Release_macos/
	--
	-- skim for MacOS https://sspai.com/post/64080
	-- let g:vimtex_view_general_viewer = '/Applications/Skim.app/Contents/SharedSupport/displayline'
	-- let g:vimtex_view_general_options = '-r @line @pdf @tex'

	-- VimTeX uses latexmk as the default compiler backend. If you use it, which is
	-- strongly recommended, you probably don't need to configure anything. If you
	-- want another compiler backend, you can change it as follows. The list of
	-- supported backends and further explanation is provided in the documentation,
	-- see ":help vimtex-compiler".
	vim.g.vimtex_compiler_method = "latexmk"
	-- use MacTex for MacOS: https://www.tug.org/mactex/
	-- or install slim version Basictex: brew install basictex

	-- Most VimTeX mappings rely on localleader and this can be changed with the
	-- following line. The default is usually fine and is the symbol "\".
	-- let maplocalleader = " "
	vim.api.nvim_set_var("maplocalleader", " ")
end
