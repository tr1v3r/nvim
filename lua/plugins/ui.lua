local ui = {}

ui["goolord/alpha-nvim"] = {
	lazy = true,
	event = "BufWinEnter",
	config = require("ui.alpha"),
}
ui["marko-cerovac/material.nvim"] = {
	lazy = false,
	priority = 1000,
	config = require("ui.material"),
}
ui["shaunsingh/nord.nvim"] = {
	lazy = false,
	priority = 1000,
	config = require("ui.nord"),
}
-- ui["nanozuki/tabby.nvim"] = {
-- 	lazy = true,
-- 	event = "BufReadPost",
-- 	config = require("ui.tabby"),
-- }
ui["akinsho/bufferline.nvim"] = {
	lazy = true,
	version = "*",
	event = { "BufReadPost", "BufAdd", "BufNewFile" },
	dependencies = "nvim-tree/nvim-web-devicons",
	config = require("ui.bufferline"),
}
ui["Jint-lzxy/nvim"] = {
	lazy = false,
	branch = "refactor/syntax-highlighting",
	name = "catppuccin",
	config = require("ui.catppuccin"),
}
ui["j-hui/fidget.nvim"] = {
	lazy = true,
	branch = "legacy",
	event = "LspAttach",
	config = require("ui.fidget"),
}
ui["lewis6991/gitsigns.nvim"] = {
	lazy = true,
	event = { "CursorHold", "CursorHoldI" },
	config = require("ui.gitsigns"),
}
ui["lukas-reineke/indent-blankline.nvim"] = {
	lazy = true,
	main = "ibl",
	opts = {},
	event = "BufReadPost",
	config = require("ui.indent-blankline"),
}
ui["nvim-lualine/lualine.nvim"] = {
	lazy = true,
	event = { "BufReadPost", "BufAdd", "BufNewFile" },
	-- dependencies = { "kdheepak/tabline.nvim" },
	config = require("ui.lualine"),
}
ui["rcarriga/nvim-notify"] = {
	lazy = true,
	event = "VeryLazy",
	config = require("ui.notify"),
}
ui["folke/paint.nvim"] = {
	lazy = true,
	event = { "CursorHold", "CursorHoldI" },
	config = require("ui.paint"),
}
-- scroll ui movement
-- ui["karb94/neoscroll.nvim"] = {
-- lazy = true,
-- event = "BufReadPost",
-- config = require("ui.neoscroll"),
-- }
-- backup: dstein64/nvim-scrollview
ui["petertriho/nvim-scrollbar"] = {
	lazy = true,
	event = "BufReadPost",
	config = require("ui.scrollbar"),
	dependencies = {
		{ "kevinhwang91/nvim-hlslens" },
		{ "lewis6991/gitsigns.nvim" },
	},
}
ui["edluffy/specs.nvim"] = {
	lazy = true,
	-- event = "CursorMoved",
	config = require("ui.specs"),
}
ui["nvim-tree/nvim-web-devicons"] = {
	lazy = true,
}
ui["luochen1990/rainbow"] = {
	lazy = true,
	event = "BufReadPost",
	config = require("ui.rainbow"),
}

return ui

-- backup
-- zbirenbaum/neodim : Neovim plugin for dimming the highlights of unused functions, variables, parameters, and more
-- kdheepak/tabline.nvim tabline support for lualine
