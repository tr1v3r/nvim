-- Native LSP bootstrap: no nvim-lspconfig / mason.nvim involved.
-- Server definitions live in `plugins/configs/completion/servers/*.lua` and
-- are enabled with the built-in `vim.lsp.config()` / `vim.lsp.enable()` API.
-- Triggered once on the first real buffer, see `event.lua` (LspBootstrap).
return function()
	local settings = require("r1v3r.settings")

	-- Rounded borders for built-in LSP floats (hover, diagnostics, ...).
	vim.lsp.util.open_floating_preview = (function(orig)
		return function(contents, syntax, opts, ...)
			opts = opts or {}
			opts.border = opts.border or "rounded"
			return orig(contents, syntax, opts, ...)
		end
	end)(vim.lsp.util.open_floating_preview)

	vim.diagnostic.config({
		signs = true,
		underline = true,
		virtual_text = false,
		virtual_lines = settings.diagnostics_virtual_lines and {
			severity = {
				min = vim.diagnostic.severity[settings.diagnostics_level],
			},
		} or false,
		update_in_insert = false,
	})

	-- Completion capabilities from blink.cmp. It lazy-loads on BufReadPre, but
	-- this handler may run first depending on autocmd registration order, so
	-- force-load it through lazy.nvim when the module is not resolvable yet.
	if not pcall(require, "blink.cmp") then
		require("lazy").load({ plugins = { "blink.cmp" } })
	end
	local ok_blink, blink = pcall(require, "blink.cmp")
	local capabilities = ok_blink and blink.get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities(), true)
		or vim.lsp.protocol.make_client_capabilities()
	vim.lsp.config("*", { capabilities = capabilities })

	local servers = vim.list_extend({}, settings.lsp_deps)
	if vim.fn.executable("dart") == 1 then
		table.insert(servers, "dartls")
	end

	for _, server_name in ipairs(servers) do
		local ok, server_config = pcall(require, "completion.servers." .. server_name)
		if not ok or type(server_config) ~= "table" then
			vim.notify(
				string.format(
					"Failed to setup [%s].\n\nServer definition under `completion/servers` must return\neither a table (got '%s' instead)",
					server_name,
					type(server_config)
				),
				vim.log.levels.ERROR,
				{ title = "nvim-lsp" }
			)
		else
			-- Merges with the "*" capabilities set above and enables the
			-- server: native filetype matching starts it on demand.
			vim.lsp.config(server_name, server_config)
			vim.lsp.enable(server_name)
		end
	end
end
