-- ================ Options ================
local o, wo, g = vim.o, vim.wo, vim.g
local global = require("r1v3r.global")

-- Syntax highlighting, affect lsp load
-- vim.cmd('syntax on')
-- Disable search highlighting after executing a search
vim.cmd([[exec "nohlsearch"]])

local options = {}

function options.g()
	return {}
end

function options.o()
	return {
		termguicolors = true,
		-- t_Co = 256, -- vim-monokai now only support 256 colours in terminal.

		-- Show command in status line
		showcmd = true,
		-- Cmmand-line height
		cmdheight = 1, -- 0/1/2
		-- Commmad-line window height
		cmdwinheight = 5,
		-- Enable wildmenu
		wildmenu = true,
		-- Enable reading configuration from current directory
		exrc = true,
		-- Enable secure mode
		secure = true,
		-- Use spaces instead of tabs
		expandtab = true,
		tabstop = 4,
		shiftwidth = 4,
		softtabstop = 4,

		-- Enable autoindent
		autoindent = true,
		-- Automatically load file when changed outside vim
		autoread = true,
		-- Automatically write file when changed outside vim
		autowrite = true,
		-- Do not create swap or backup files
		backup = false,
		swapfile = false,
		-- Disable indent expression
		indentexpr = "",
		-- Show whitespace characters
		listchars = "tab:| ,trail:☒",
		-- Set the number of lines to keep above and below the cursor in scroll off
		scrolloff = 4,
		-- Disable the time delay for key codes
		ttimeoutlen = 0,
		timeout = false,
		-- Set view options for saving and restoring folds, slash search, Unix line endings
		viewoptions = "cursor,folds,curdir,slash,unix",
		-- Disable text width
		tw = 0,
		-- Set fold method to syntax
		foldmethod = "syntax",
		-- Set fold level to maximum
		foldlevel = 99,
		-- Enable folding
		foldenable = true,
		-- Disable automatic formatting for comments
		formatoptions = o.formatoptions:gsub("tc", ""),
		-- Split windows to the right and below
		splitright = true,
		splitbelow = true,
		-- Hide mode from status line
		showmode = false,
		-- Enable search highlighting
		hlsearch = true,
		-- Enable incremental search
		incsearch = true,
		-- Ignore case in search unless an uppercase character is used
		ignorecase = true,
		smartcase = true,
		-- Shorten error messages
		shortmess = o.shortmess .. "flnrwx",
		-- Open command-line window in split mode
		inccommand = "split",
		-- Set completion options
		completeopt = "noinsert,longest,menuone,noselect,preview",
		-- Enable lazy redraw
		lazyredraw = true,
		-- Use visual bell instead of beeping sound
		visualbell = true,
		-- Set the time interval for writing swap and backup files
		updatetime = 300,
		-- Enable blockwise virtual editing
		virtualedit = "block",
		-- Automatically change the current directory to the directory of the current file
		autochdir = true,
		-- Automatically write all buffers when executing certain commands
		autowriteall = true,
		-- signcolumn = 'nubmer'
		-- Set backup file dir
		backupdir = global.cache_dir .. "backup//",
		-- Set swap file dir
		directory = global.cache_dir .. "swap//",
		-- Set undo file dir
		undodir = global.cache_dir .. "undo//",
		-- Save undo history
		undofile = true,

		sessionoptions = "buffers,curdir,folds,help,tabpages,winpos,winsize",
		shada = "!,'500,<50,@100,s10,h",
		hidden = true,
		-- Set the format of grep output
		grepformat = "%f:%l:%c:%m",
		-- Set grep program to ripgrep
		grepprg = "rg --hidden --vimgrep --smart-case",
		-- Set command history recorded items
		history = 2000,
	}
end

function options.wo()
	return {
		list = true,
		-- Line numbers
		number = true,
		relativenumber = true,

		-- Highlight current line
		cursorline = true,
		-- Enable line wrapping
		wrap = true,
		-- Highlight a column at a specific width
		colorcolumn = "120",
	}
end

-- local function isempty(s)
-- 	return s == nil or s == ""
-- end
local function use_if_defined(val, fallback)
	return val ~= nil and val or fallback
end

function options.set_provider()
	-- custom python provider
	local conda_python_exe = os.getenv("CONDA_PYTHON_EXE")
	if conda_python_exe then
		vim.g.python_host_prog = use_if_defined(vim.g.python_host_prog, conda_python_exe)
		vim.g.python3_host_prog = use_if_defined(vim.g.python3_host_prog, conda_python_exe)
	else
		vim.g.python_host_prog = use_if_defined(vim.g.python_host_prog, "python")
		vim.g.python3_host_prog = use_if_defined(vim.g.python3_host_prog, "python3")
	end
end

function options.init()
	options.set_provider()

	for k, v in pairs(options.g()) do
		g[k] = v
	end
	for k, v in pairs(options.o()) do
		o[k] = v
	end
	for k, v in pairs(options.wo()) do
		wo[k] = v
	end
end

options.init()
