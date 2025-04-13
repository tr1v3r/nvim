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
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<CR>",
				node_incremental = "<CR>",
				-- scope_incremental = "<CR>",
				node_decremental = "<BS>",
			},
		},
		textobjects = {
			-- docs: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
			select = {
				enable = true,
				keymaps = {
					["af"] = "@function.outer",
					["kf"] = "@function.inner",
					["ac"] = "@class.outer",
					["kc"] = "@class.inner",
				},
			},
			move = {
				enable = true,
				set_jumps = true, -- whether to set jumps in the jumplist
				goto_next_start = {
					["]["] = "@block.outer",
					["]f"] = "@function.outer",
					["]m"] = "@class.outer",
				},
				goto_next_end = {
					["]]"] = "@block.outer",
					["]F"] = "@function.outer",
					["]M"] = "@class.outer",
				},
				goto_previous_start = {
					["[["] = "@block.outer",
					["[f"] = "@function.outer",
					["[m"] = "@class.outer",
				},
				goto_previous_end = {
					["[]"] = "@block.outer",
					["[F"] = "@function.outer",
					["[M"] = "@class.outer",
				},
			},
		},
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
