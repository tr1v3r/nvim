return function()
	require("better_escape").setup({
		timeout = vim.o.timeoutlen, -- the time in which the keys must be hit in ms. Use option timeoutlen by default
		default_mappings = false,
		mappings = {
			i = {
				k = {
					k = function()
						vim.api.nvim_input("<esc>")
						local current_line = vim.api.nvim_get_current_line()
						if current_line:match("^%s+k$") then
							vim.schedule(function()
								vim.api.nvim_set_current_line("")
							end)
						end
					end,
				},
			},
			-- c = {
			-- 	k = {
			-- 		k = "<Esc>",
			-- 	},
			-- },
			-- t = {
			-- 	k = {
			-- 		k = "<C-\\><C-n>",
			-- 	},
			-- },
			-- v = {
			-- 	k = {
			-- 		k = "<Esc>",
			-- 	},
			-- },
			-- s = {
			-- 	k = {
			-- 		k = "<Esc>",
			-- 	},
			-- },
		},
	})
end
