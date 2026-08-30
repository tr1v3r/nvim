return function()
	local transparent_background = require("r1v3r.settings").transparent_background

	require("tokyonight").setup({
		-- style variant: "night" | "storm" | "day" | "moon"
		style = "night",
		light_style = "day",
		transparent = transparent_background,
		terminal_colors = true,
		styles = {
			comments = { italic = true },
			keywords = { italic = true },
			functions = {},
			variables = {},
			sidebars = transparent_background and "transparent" or "dark",
			floats = transparent_background and "transparent" or "dark",
		},
		sidebars = { "qf", "help", "neo-tree", "NvimTree", "toggleterm" },
		-- dim_inactive = true,
		-- lualine_bold = true,
	})
end
