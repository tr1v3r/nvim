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
	-- Setup reads history asynchronously; the first picker needs it before building its finder.
	local history = require("project_nvim.utils.history")
	if vim.fn.filereadable(require("project_nvim.utils.path").historyfile) == 1 then
		vim.wait(1000, function()
			return history.recent_projects ~= nil
		end, 10)
	end
	-- When loaded after VimEnter, detect the current buffer immediately.
	require("project_nvim.project").on_buf_enter()
end
