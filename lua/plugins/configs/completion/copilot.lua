return function()
	vim.defer_fn(function()
		require("copilot").setup({
			-- panel/suggestion must stay disabled: completions are surfaced
			-- inside blink.cmp via `blink-cmp-copilot`.
			panel = {
				enabled = false,
			},
			suggestion = {
				enabled = false,
			},
			filetypes = {
				["dap-repl"] = false,
				bigfile = false,
			},
		})
	end, 100)
end
