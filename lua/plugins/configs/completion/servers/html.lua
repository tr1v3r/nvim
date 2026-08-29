-- https://github.com/hrsh7th/vscode-langservers-extracted (brew: vscode-langservers-extracted)
return {
	cmd = { "vscode-html-language-server", "--stdio" },
	filetypes = { "html" },
	root_markers = { "package.json", ".git" },
	init_options = {
		configurationSection = { "html", "css", "javascript" },
		embeddedLanguages = { css = true, javascript = true },
	},
	settings = {},
	flags = { debounce_text_changes = 500 },
}
