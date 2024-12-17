return function()
	local transparent_background = require("r1v3r.settings").transparent_background

	require("monokai-pro").setup({
		filter = "pro", -- 配色风格
		transparent_background = transparent_background,
		terminal_colors = true,
		devicons = true,
		italic_comments = true,
		background_clear = {
			-- "float_win",
			"toggleterm",
			"telescope",
			-- "which-key",
			"renamer",
			"notify",
			-- "nvim-tree",
			-- "neo-tree",
			-- "bufferline", -- better used if background of `neo-tree` or `nvim-tree` is cleared
		}, -- "float_win", "toggleterm", "telescope", "which-key", "renamer", "neo-tree", "nvim-tree", "bufferline"
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
end
