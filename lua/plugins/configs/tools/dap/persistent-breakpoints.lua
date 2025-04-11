return function()
	require("persistent-breakpoints").setup({
		save_dir = vim.fn.stdpath("data") .. "/nvim_checkpoints",
		-- when to load the breakpoints? "BufReadPost" is recommanded.
		load_breakpoints_event = { "BufReadPost" },
	})
end
