-- https://github.com/typescript-language-server/typescript-language-server (npm: typescript@6 + typescript-language-server)
return {
	cmd = { "typescript-language-server", "--stdio" },
	filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
	root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
	init_options = {
		hostInfo = "neovim",
		-- Avoid syntax-only results while the semantic project is loading.
		tsserver = { useSyntaxServer = "never" },
	},
	flags = { debounce_text_changes = 500 },
}
