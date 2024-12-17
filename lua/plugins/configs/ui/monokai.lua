return function()
	local transparent_background = require("r1v3r.settings").transparent_background

	require("monokai-pro").setup({
		-- filter = "spectrum", -- 配色风格 classic | octagon | pro | machine | ristretto | spectrum
		-- Enable this will disable filter option
		day_night = {
			enable = true, -- turn off by default
			day_filter = "pro", -- classic | octagon | pro | machine | ristretto | spectrum
			night_filter = "spectrum", -- classic | octagon | pro | machine | ristretto | spectrum
		},
		transparent_background = transparent_background,
		terminal_colors = true,
		devicons = true,
		styles = {
			comment = { italic = true },
			keyword = { italic = true }, -- any other keyword
			type = { italic = true }, -- (preferred) int, long, char, etc
			storageclass = { italic = true }, -- static, register, volatile, etc
			structure = { italic = true }, -- struct, union, enum, etc
			parameter = { italic = true }, -- parameter pass in function
			annotation = { italic = true },
			tag_attribute = { italic = true }, -- attribute of tag in reactjs
		},
		inc_search = "background", -- underline | background
		background_clear = {
			-- "float_win",
			-- "toggleterm",
			"telescope",
			"which-key",
			-- "renamer",
			"notify",
			"nvim-tree",
			-- "neo-tree",
			"bufferline", -- better used if background of `neo-tree` or `nvim-tree` is cleared
			-- "float_win", "toggleterm", "telescope", "which-key", "renamer", "neo-tree", "nvim-tree", "bufferline"
		},
		plugins = {
			bufferline = {
				underline_selected = false,
				underline_visible = false,
			},
			indent_blankline = {
				context_highlight = "default", -- default | pro
				context_start_underline = false,
			},
		},
	})
	-- vim.cmd.colorscheme("monokai-pro")
	-- vim.print("monokai " .. require("monokai-pro.colorscheme").get().notifications.background)
end
