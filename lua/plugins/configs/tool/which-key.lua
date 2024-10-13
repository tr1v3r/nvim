return function()
	local icons = {
		ui = require("r1v3r.icons").get("ui"),
		misc = require("r1v3r.icons").get("misc"),
	}

	require("which-key").setup({
		plugins = {
			presets = {
				operators = false,
				motions = false,
				text_objects = false,
				windows = false,
				nav = false,
				z = true,
				g = true,
			},
		},

		icons = {
			breadcrumb = icons.ui.Separator,
			separator = icons.misc.Vbar,
			group = icons.misc.Add,
		},

		win = {
			border = "none",
			padding = { 1, 2 }, -- extra window padding [top/bottom, right/left]
			wo = {
				winblend = 10, -- value between 0-100 0 for fully opaque and 100 for fully transparent
			},
		},
	})
end
