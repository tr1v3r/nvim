local M = {}

---@type snacks.Config
M.opts = {
	bigfile = { enabled = true },
	-- dashboard = { enabled = true },
	-- explorer = { enabled = true },
	-- indent = { enabled = true },
	input = { enabled = true },
	picker = { enabled = true },
	-- notifier = { enabled = true },
	quickfile = { enabled = true },
	scope = { enabled = true },
	-- scroll = { enabled = true },
	-- statuscolumn = { enabled = true },
	-- words = { enabled = true },

	scratch = {
		win = {
			-- input = {
			-- 	keys = {
			-- 		["input_test"] = {
			-- 			"<c-d>",
			-- 			function(self)
			-- 				vim.notify(vim.inspect(self))
			-- 			end,
			-- 			desc = "Source buffer abc",
			-- 		},
			-- 	},
			-- },
			keys = {
				["delete"] = {
					"<C-D>",
					function(self)
						local bufn = self.buf
						local filename = vim.api.nvim_buf_get_name(bufn)

						vim.api.nvim_buf_delete(bufn, { force = true })

						local success, err = os.remove(filename)
						if success then
							vim.notify("File deleted: " .. filename, vim.log.levels.INFO)
						else
							vim.notify("Delete file fail: " .. (err or "unknown error"), vim.log.levels.ERROR)
						end

						Snacks.scratch.select()
					end,
					desc = "delete",
					mode = { "n", "x" },
				},
			},
		},
	},
}

return M
