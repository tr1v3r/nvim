-- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/server_configurations/gopls.lua
-- https://github.com/golang/tools/blob/master/gopls/doc/settings.md
-- issue: https://github.com/neovim/neovim/issues/28058
return {
	flags = { debounce_text_changes = 500 },
	cmd = { "gopls", "-remote=auto" },
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	root_dir = vim.fs.dirname(vim.fs.find({ "go.work", "go.mod" }, { upward = true })[1]),
	single_file_support = true,
	settings = {
		gopls = {
			usePlaceholders = true,
			analyses = {
				nilness = true,
				shadow = true,
				unusedparams = true,
				unusewrites = true,
			},
		},
	},
}
