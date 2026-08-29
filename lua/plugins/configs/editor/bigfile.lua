return function()
	local ftdetect = {
		name = "ftdetect",
		opts = { defer = true },
		disable = function()
			vim.opt_local.filetype = "big_file_disabled_ft"
		end,
	}

	local cmp = {
		name = "blink.cmp",
		opts = { defer = true },
		disable = function()
			vim.b.completion_disabled = true
		end,
	}

	require("bigfile").setup({
		filesize = 3, -- size of the file in MiB
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
