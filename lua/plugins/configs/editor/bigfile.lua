return function()
	local ftdetect = {
		name = "ftdetect",
		opts = { defer = true },
		disable = function()
			vim.opt_local.filetype = "big_file_disabled_ft"
		end,
	}

	local cmp = {
		name = "nvim-cmp",
		opts = { defer = true },
		disable = function()
			require("cmp").setup.buffer({ enabled = false })
		end,
	}

	require("bigfile").setup({
		filesize = 1, -- size of the file in MiB
		pattern = { "*" }, -- autocmd pattern
		features = { -- features to disable
			"indent_blankline",
			"lsp",
			"illuminate",
			"treesitter",
			"syntax",
			"vimopts",
			ftdetect,
			cmp,
		},
	})
end
