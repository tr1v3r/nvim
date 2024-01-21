return function()
	require("illuminate").configure({
		providers = {
			"lsp",
			"treesitter",
			"regex",
		},
		delay = 100,
		filetypes_denylist = {
			"DoomInfo",
			"DressingSelect",
			"NvimTree",
			"TelescopePrompt",
			"Trouble",
			"aerial",
			"alpha",
			"dashboard",
			"dirvish",
			"fugitive",
			"help",
			"neogitstatus",
			"norg",
			"toggleterm",
		},
		under_cursor = false,
	})
end
