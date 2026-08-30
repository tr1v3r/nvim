return function()
	local icons = require("r1v3r.icons").get("ui")

	require("trouble").setup({
		auto_close = false,
		auto_open = false,
		auto_preview = true,
		focus = false,
		win = {
			position = "bottom",
			size = 10,
		},
		keys = {
			["<tab>"] = "jump",
			["<c-x>"] = "jump_split",
			["<c-v>"] = "jump_vsplit",
		},
		icons = {
			indent = {
				fold_open = icons.ArrowOpen .. " ",
				fold_closed = icons.ArrowClosed .. " ",
			},
		},
	})
end
