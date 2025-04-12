local editor = {}
local keymaps = require("r1v3r.keymaps")

-- Disabled for performance reasons: accelerated-jk.nvim provides faster j/k motions but may conflict with other motion plugins or recording macros.
-- editor["rainbowhxch/accelerated-jk.nvim"] = {
-- 	lazy = true,
-- 	event = "VeryLazy",
-- 	keys = keymaps.accelerated_jk(),
-- 	config = require("editor.accelerated-jk"),
-- }
-- editor["rmagatti/auto-session"] = {
-- 	lazy = true,
-- 	cmd = { "SessionSave", "SessionRestore", "SessionDelete" },
-- 	config = require("editor.auto-session"),
-- }
editor["olimorris/persisted.nvim"] = {
	lazy = true,
	cmd = {
		"SessionToggle",
		"SessionStart",
		"SessionStop",
		"SessionSave",
		"SessionLoad",
		"SessionLoadLast",
		"SessionLoadFromFile",
		"SessionDelete",
	},
	keys = keymaps.persisted(),
	config = require("editor.persisted"),
}
editor["m4xshen/autoclose.nvim"] = {
	lazy = true,
	event = "InsertEnter",
	config = require("editor.autoclose"),
}
editor["max397574/better-escape.nvim"] = {
	lazy = true,
	event = { "CursorHold", "CursorHoldI" },
	config = require("editor.better-escape"),
}
editor["LunarVim/bigfile.nvim"] = {
	cond = require("r1v3r.settings").load_big_files_faster,
	lazy = false,
	config = require("editor.bigfile"),
}
editor["ojroques/nvim-bufdel"] = {
	lazy = true,
	cmd = { "BufDel", "BufDelAll", "BufDelOthers" },
	keys = keymaps.bufdel(),
	config = require("editor.nvim-bufdel"),
}
-- NOTE: `flash.nvim` is a powerful plugin that can be used as partial or complete replacements for:
--  > `hop.nvim`,
--  > `wilder.nvim`
--  > `nvim-treehopper`
-- Considering its steep learning curve as well as backward compatibility issues...
--  > We have no plan to remove the above plugins for the time being.
-- But as usual, you can always tweak the plugin to your liking.
editor["folke/flash.nvim"] = {
	lazy = true,
	event = { "CursorHold", "CursorHoldI" },
	keys = keymaps.flash(),
	config = require("editor.flash"),
}
editor["numToStr/Comment.nvim"] = {
	lazy = true,
	event = { "CursorHold", "CursorHoldI" },
	keys = keymaps.comment(),
	config = require("editor.comment"),
}
editor["sindrets/diffview.nvim"] = {
	lazy = true,
	cmd = { "DiffviewOpen", "DiffviewClose" },
	keys = keymaps.diffview(),
}
editor["junegunn/vim-easy-align"] = {
	lazy = true,
	cmd = "EasyAlign",
	keys = keymaps.easy_align(),
}
editor["RRethy/vim-illuminate"] = {
	lazy = true,
	event = { "CursorHold", "CursorHoldI" },
	config = require("editor.vim-illuminate"),
}
-- editor["romainl/vim-cool"] = { -- auto no highlight
-- 	lazy = true,
-- 	event = { "CursorMoved", "InsertEnter" },
-- }
editor["lambdalisue/suda.vim"] = {
	lazy = true,
	cmd = { "SudaRead", "SudaWrite" },
	keys = keymaps.suda(),
	config = require("editor.suda"),
}
editor["kevinhwang91/nvim-hlslens"] = {
	lazy = true,
	event = "BufReadPost",
	config = require("editor.hlslens"),
}
editor["sustech-data/wildfire.nvim"] = {
	lazy = true,
	event = "VeryLazy",
	keys = keymaps.wildfire(),
	config = require("editor.wildfire"),
	vsc = true,
}
-- tpope/vim-surround old version by vimscript
editor["kylechui/nvim-surround"] = {
	lazy = true,
	event = "BufReadPost",
	config = require("editor.nvim-surround"),
	vsc = true,
}
-- mg979/vim-visual-multi

----------------------------------------------------------------------
--                  :treesitter related plugins                    --
----------------------------------------------------------------------
-- nvim-treesitter/playground Run :TSPlaygroundToggle show AST of current file
editor["nvim-treesitter/nvim-treesitter"] = {
	lazy = true,
	build = function()
		if #vim.api.nvim_list_uis() ~= 0 then
			vim.api.nvim_command([[TSUpdate]])
		end
	end,
	event = "BufReadPre",
	config = require("editor.treesitter"),
	dependencies = {
		{ "andymass/vim-matchup" },
		{ "nvim-treesitter/nvim-treesitter-textobjects" },
		{
			"abecodes/tabout.nvim",
			keys = keymaps.tabout(),
			config = require("editor.tabout"),
		},
		{
			"windwp/nvim-ts-autotag",
			config = require("editor.autotag"),
		},
		{
			"NvChad/nvim-colorizer.lua",
			config = require("editor.colorizer"),
		},
		{
			"hiphish/rainbow-delimiters.nvim",
			config = require("editor.rainbow_delims"),
		},
		{
			"nvim-treesitter/nvim-treesitter-context",
			config = require("editor.ts-context"),
		},
	},
}

-- deprecated plugins
-- phaazon/hop.nvim v2
-- smoka7/hop.nvim

return editor
