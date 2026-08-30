return function()
	require("persistent-breakpoints").setup({
		save_dir = vim.fn.stdpath("data") .. "/nvim_checkpoints",
		-- Load breakpoints for buffers opened after DAP has initialized.
		load_breakpoints_event = { "BufReadPost" },
	})
	-- DAP is lazy-loaded, so restore breakpoints for buffers that are already open.
	require("persistent-breakpoints.api").load_breakpoints()
end
