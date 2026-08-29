-- Minimal mason setup: it only remains installed to drive mason-nvim-dap
-- (DAP adapters). LSP servers and formatter binaries are system packages now
-- (see the `lsp_deps` / `null_ls_deps` notes in `r1v3r/settings.lua`).
return function()
	require("mason").setup({
		ui = {
			border = "single",
		},
	})
end
