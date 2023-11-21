return function()
	-- BREAKING CHANGES: nvim-treesitter module deprecated, detail: https://github.com/JoosepAlviste/nvim-ts-context-commentstring/issues/82
	vim.g.skip_ts_context_commentstring_module = true
	require("ts_context_commentstring").setup({
		-- Whether to update the `commentstring` on the `CursorHold` autocmd
		enable_autocmd = false,
	})
end
