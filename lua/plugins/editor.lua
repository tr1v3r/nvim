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
	event = "InsertEnter",
	config = require("editor.better-escape"),
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
	event = "VeryLazy",
	keys = keymaps.flash(),
	config = require("editor.flash"),
}
editor["numToStr/Comment.nvim"] = {
	lazy = true,
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
	event = { "BufReadPost", "BufNewFile" },
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
-- editor["sustech-data/wildfire.nvim"] = { -- use nvim-treesitter instead
-- 	lazy = true,
-- 	event = "VeryLazy",
-- 	keys = keymaps.wildfire(),
-- 	config = require("editor.wildfire"),
-- 	vsc = true,
-- }
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
editor["andymass/vim-matchup"] = {
	lazy = true,
	event = { "BufReadPre", "BufNewFile" },
}
editor["abecodes/tabout.nvim"] = {
	lazy = true,
	event = "InsertEnter",
	keys = keymaps.tabout(),
	config = require("editor.tabout"),
}
editor["windwp/nvim-ts-autotag"] = {
	lazy = true,
	ft = { "html", "javascript", "javascriptreact", "typescriptreact", "vue", "xml" },
	config = require("editor.autotag"),
}
editor["NvChad/nvim-colorizer.lua"] = {
	lazy = true,
	ft = {
		"css",
		"html",
		"javascript",
		"javascriptreact",
		"less",
		"lua",
		"sass",
		"scss",
		"svelte",
		"typescript",
		"typescriptreact",
		"vue",
	},
	config = require("editor.colorizer"),
}
editor["hiphish/rainbow-delimiters.nvim"] = {
	lazy = true,
	event = { "BufReadPre", "BufNewFile" },
	config = require("editor.rainbow_delims"),
}
editor["nvim-treesitter/nvim-treesitter-context"] = {
	lazy = true,
	event = { "BufReadPost", "BufNewFile" },
	config = require("editor.ts-context"),
}
editor["nvim-treesitter/nvim-treesitter"] = {
	branch = "main",
	lazy = true,
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	config = require("editor.treesitter"),
	dependencies = {
		{ "nvim-treesitter/nvim-treesitter-textobjects", branch = "main" },
	},
}

-- deprecated plugins
-- phaazon/hop.nvim v2
-- smoka7/hop.nvim

return editor
