-- Run :set rtp? to list all nvim config dirs will be searched when neovim start
local global = require("r1v3r.global")
local settings = require("r1v3r.settings")

-- create_dir cache dir and data dirs
local create_dir = function()
	local dataDir = {
		global.cache_dir .. "backup",
		global.cache_dir .. "undo",
		global.cache_dir .. "session",
		global.cache_dir .. "swap",
		global.cache_dir .. "tags",
	}
	-- Only check whether cache_dir exists, this would be enough.
	if vim.fn.isdirectory(global.cache_dir) == 0 then
		os.execute("mkdir -p " .. global.cache_dir)
		local success, _, code = os.execute("mkdir -p " .. global.cache_dir)
		if not success then
			print("Error: Unable to create directory " .. global.cache_dir .. ". Exit code:", code)
		end
		for _, v in pairs(dataDir) do
			if vim.fn.isdirectory(v) == 0 then
				os.execute("mkdir -p " .. v)
			end
		end
	end
end

local disable_distribution_plugins = function()
	-- Disable menu loading
	vim.g.did_install_default_menus = 1
	vim.g.did_install_syntax_menu = 1

	-- Comment this if you define your own filetypes in `after/ftplugin`
	-- vim.g.did_load_filetypes = 1

	-- Do not load native syntax completion
	vim.g.loaded_syntax_completion = 1

	-- Do not load spell files
	vim.g.loaded_spellfile_plugin = 1

	-- Whether to load netrw by default
	-- vim.g.loaded_netrw = 1
	-- vim.g.loaded_netrwFileHandlers = 1
	-- vim.g.loaded_netrwPlugin = 1
	-- vim.g.loaded_netrwSettings = 1
	-- newtrw liststyle: https://medium.com/usevim/the-netrw-style-options-3ebe91d42456
	vim.g.netrw_liststyle = 3

	-- Do not load tohtml.vim
	vim.g.loaded_2html_plugin = 1

	-- Do not load zipPlugin.vim, gzip.vim and tarPlugin.vim (all of these plugins are
	-- related to reading files inside compressed containers)
	vim.g.loaded_gzip = 1
	vim.g.loaded_tar = 1
	vim.g.loaded_tarPlugin = 1
	vim.g.loaded_vimball = 1
	vim.g.loaded_vimballPlugin = 1
	vim.g.loaded_zip = 1
	vim.g.loaded_zipPlugin = 1

	-- Do not use builtin matchit.vim and matchparen.vim because we're using vim-matchup
	vim.g.loaded_matchit = 1
	vim.g.loaded_matchparen = 1

	-- Disable sql omni completion
	vim.g.loaded_sql_completion = 1

	-- Set this to 0 in order to disable native EditorConfig support
	vim.g.editorconfig = 1

	-- Disable remote plugins
	-- NOTE:
	--  > Disabling rplugin.vim will make `wilder.nvim` complain about missing rplugins during :checkhealth,
	--  > but since it's config doesn't require python rtp (strictly), it's fine to ignore that for now.
	-- vim.g.loaded_remote_plugins = 1
end

local neovide_config = function()
	for name, config in pairs(settings.neovide_config) do
		vim.g["neovide_" .. name] = config
	end
end

-- https://neovim.io/doc/user/lua-guide.html#_-vim.opt
-- https://neovim.io/doc/user/lua.html#vim.o
-- https://neovim.io/doc/user/lua.html#vim.opt
local gui_config = function()
	vim.o.guifont = settings.gui_config.font_name .. ":h" .. settings.gui_config.font_size

	if vim.g.neovide then
		neovide_config()
	end
end

local clipboard_config = function()
	if global.is_mac then
		vim.g.clipboard = {
			name = "macOS-clipboard",
			copy = { ["+"] = "pbcopy", ["*"] = "pbcopy" },
			paste = { ["+"] = "pbpaste", ["*"] = "pbpaste" },
			cache_enabled = 0,
		}
	elseif global.is_wsl then
		vim.g.clipboard = {
			name = "win32yank-wsl",
			copy = {
				["+"] = "win32yank.exe -i --crlf",
				["*"] = "win32yank.exe -i --crlf",
			},
			paste = {
				["+"] = "win32yank.exe -o --lf",
				["*"] = "win32yank.exe -o --lf",
			},
			cache_enabled = 0,
		}
	end
end

-- device_config load device config
local device_config = function()
	local deviceConfig = os.getenv("HOME") .. "/.config/nvim/_device.lua"
	if vim.fn.empty(vim.fn.glob(deviceConfig)) == 1 then
		print("device lua not found")
	else
		dofile(deviceConfig)
	end
end

local init = function()
	create_dir()
	disable_distribution_plugins()

	gui_config()
	clipboard_config()

	require("r1v3r.lang")
	require("r1v3r.options")
	require("r1v3r.keymaps")
	require("r1v3r.event")
	require("r1v3r.pack")
	require("r1v3r.method")

	vim.api.nvim_command("set background=" .. settings.background)
	vim.cmd.colorscheme(settings.colorscheme)

	device_config()
end

init()
