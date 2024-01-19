return function()
	vim.g.wildfire_objects = {
		["*"] = { "i'", 'i"', "i)", "i]", "i}" },
		["html,xml"] = { "at", "it" },
	}
end
