local is_mac = require("r1v3r.global").is_mac

local icons = {
	kind = require("r1v3r.icons").get("kind"),
	documents = require("r1v3r.icons").get("documents"),
	ui = require("r1v3r.icons").get("ui"),
	ui_sep = require("r1v3r.icons").get("ui", true),
	misc = require("r1v3r.icons").get("misc"),
}
-- vim.fn.stdpath("data") default value: ~/.local/share/nvim/
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  local output =  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
	if vim.api.nvim_get_vvar("shell_error") ~= 0 then
		vim.api.nvim_err_writeln("Error cloning lazy.nvim repository...\n\n" .. output)
	end
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

-- README: https://github.com/folke/lazy.nvim
require('lazy').setup({
	{ -- colorscheme is always first priority
		"marko-cerovac/material.nvim",
		lazy = false,
		priority = 1000,
		config = function()
		-- vim.g.material_terminal_italics = 1
		-- vim.g.material_theme_style = 'default' | 'palenight' | 'ocean' | 'lighter' | 'darker' | 'default-community' | 'palenight-community' | 'ocean-community' | 'lighter-community' | 'darker-community'
		-- vim.g.material_theme_style = 'ocean-community'
		-- vim.g.material_style = "darker" | "lighter" | "oceanic" | "palenight" | "deep ocean"
			vim.g.material_style = "deep ocean"

			vim.cmd("colorscheme material")
		end,
	},

	{
		"dstein64/vim-startuptime",
		-- lazy-load on a command
		cmd = "StartupTime",
		-- init is called during startup. Configuration for vim plugins typically should be set in an init function
		init = function()
		  vim.g.startuptime_tries = 10
		end,
	},

	-- old name: kyazdani42/nvim-web-devicons
	{ "nvim-tree/nvim-web-devicons", lazy = true },

	-- Unmanaged plugin (manually installed and updated)
	{ dir = "~/my-prototype-plugin" },
	},

	{
		ui = {
			-- a number <1 is a percentage., >1 is a fixed size
			size = { width = 0.88, height = 0.8 },
			wrap = true, -- wrap the lines in the ui
			-- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
			border = "rounded",
			icons = {
				cmd = icons.misc.Code,
				config = icons.ui.Gear,
				event = icons.kind.Event,
				ft = icons.documents.Files,
				init = icons.misc.ManUp,
				import = icons.documents.Import,
				keys = icons.ui.Keyboard,
				loaded = icons.ui.Check,
				not_loaded = icons.misc.Ghost,
				plugin = icons.ui.Package,
				runtime = icons.misc.Vim,
				source = icons.kind.StaticMethod,
				start = icons.ui.Play,
				list = {
					icons.ui_sep.BigCircle,
					icons.ui_sep.BigUnfilledCircle,
					icons.ui_sep.Square,
					icons.ui_sep.ChevronRight,
				},
			},
		},
		performance = {
			cache = {
				enabled = true,
			},
			path = vim.fn.stdpath("cache") .. "/lazy/cache",
				-- Once one of the following events triggers, caching will be disabled.
				-- To cache all modules, set this to `{}`, but that is not recommended.
				disable_events = { "UIEnter", "BufReadPre" },
				ttl = 3600 * 24 * 2, -- keep unused modules for up to 2 days
		},
})

if is_mac then
    -- lazy_settings.concurrency = 20
end
