return function()
	local transparent_background = require("r1v3r.settings").transparent_background

	require("monokai-pro").setup({
		filter = "pro", -- 配色风格
		transparent_background = transparent_background,
		terminal_colors = true,
		devicons = true,
		italic_comments = true,
	})
	-- vim.cmd.colorscheme("monokai-pro")
end
