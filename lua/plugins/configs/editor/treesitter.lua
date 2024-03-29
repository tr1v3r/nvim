return vim.schedule_wrap(function()
	vim.o.foldmethod = "expr"
	vim.o.foldexpr = "nvim_treesitter#foldexpr()"

	require("nvim-treesitter.configs").setup({
		ensure_installed = require("r1v3r.settings").treesitter_deps,
		highlight = {
			enable = true,
			disable = function(ft, bufnr)
				if vim.tbl_contains({ "vim" }, ft) then
					return true
				end

				local ok, is_large_file = pcall(vim.api.nvim_buf_get_var, bufnr, "bigfile_disable_treesitter")
				return ok and is_large_file
			end,
			additional_vim_regex_highlighting = false,
		},
		textobjects = {
			select = {
				enable = true,
				keymaps = {
					["af"] = "@function.outer",
					["if"] = "@function.inner",
					["ac"] = "@class.outer",
					["ic"] = "@class.inner",
				},
			},
			move = {
				enable = true,
				set_jumps = true, -- whether to set jumps in the jumplist
				goto_next_start = {
					["]["] = "@function.outer",
					["]m"] = "@class.outer",
				},
				goto_next_end = {
					["]]"] = "@function.outer",
					["]M"] = "@class.outer",
				},
				goto_previous_start = {
					["[["] = "@function.outer",
					["[m"] = "@class.outer",
				},
				goto_previous_end = {
					["[]"] = "@function.outer",
					["[M"] = "@class.outer",
				},
			},
		},
		-- context_commentstring = { @deprecated at 2023.11.21, can be delete after 3 month(after 2024.1.21)
		-- 	enable = true,
		-- 	enable_autocmd = false
		-- },
		indent = { enable = true },
		matchup = { enable = true },
	})
	require("nvim-treesitter.install").prefer_git = true
	-- if use_ssh then
	--	 local parsers = require("nvim-treesitter.parsers").get_parser_configs()
	--	 for _, p in pairs(parsers) do
	--		 p.install_info.url = p.install_info.url:gsub("https://github.com/", "git@github.com:")
	--	 end
	-- end
end)
