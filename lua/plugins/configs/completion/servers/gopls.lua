-- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/server_configurations/gopls.lua
-- https://github.com/golang/tools/blob/master/gopls/doc/settings.md
return {
	flags = { debounce_text_changes = 500 },
	cmd = { "gopls", "-remote=auto" },
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
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
