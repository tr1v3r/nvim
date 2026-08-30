return function()
	require("project_nvim").setup({
		manual_mode = false,
		detection_methods = { "pattern" },
		patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },
		exclude_dirs = {},
		show_hidden = false,
		silent_chdir = true,
		scope_chdir = "global",
		datapath = vim.fn.stdpath("data"),
	})
	-- When loaded after VimEnter, detect the current buffer immediately.
	require("project_nvim.project").on_buf_enter()
end
