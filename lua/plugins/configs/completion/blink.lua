return function()
	local use_copilot = require("r1v3r.settings").use_copilot

	local icons = {
		kind = require("r1v3r.icons").get("kind"),
		type = require("r1v3r.icons").get("type"),
	}

	local sources = { "lsp", "path", "snippets", "buffer", "latex_symbols" }
	if use_copilot then
		table.insert(sources, 1, "copilot")
	end

	local providers = {
		-- nvim-cmp source proxied through blink.compat
		latex_symbols = {
			name = "latex_symbols",
			module = "blink.compat.source",
		},
	}
	if use_copilot then
		-- https://github.com/giuxtaposition/blink-cmp-copilot
		providers.copilot = {
			name = "copilot",
			module = "blink-cmp-copilot",
			score_offset = 100,
			async = true,
		}
	end

	-- `sources.default` also accepts a context function: snacks.bigfile marks
	-- large buffers with the `bigfile` filetype and disables completion.
	local function resolve_sources()
		if vim.b.completion == false or vim.bo.filetype == "bigfile" then
			return {}
		end
		return sources
	end

	require("blink.cmp").setup({
		-- https://cmp.saghen.dev/configuration/keymap.html
		keymap = {
			preset = "enter",
			["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
			["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
			-- Keep the old nvim-cmp muscle memory: `<C-e>` jumps within snippets.
			["<C-e>"] = { "snippet_forward", "fallback" },
			["<C-d>"] = { "scroll_documentation_down", "fallback" },
			["<C-f>"] = { "scroll_documentation_up", "fallback" },
			["<C-w>"] = { "hide", "fallback" },
			-- Accept the top-ranked completion (copilot sorts first); replaces
			-- the old `<C-i>` quick-accept from copilot-cmp.
			["<C-i>"] = { "select_and_accept" },
		},
		appearance = {
			nerd_font_variant = "mono",
			kind_icons = vim.tbl_deep_extend("force", icons.kind, icons.type),
		},
		snippets = { preset = "luasnip" },
		sources = {
			default = resolve_sources,
			providers = providers,
		},
		completion = {
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 200,
				window = { border = "rounded" },
			},
			menu = { border = "rounded" },
			ghost_text = { enabled = true },
		},
		-- Replaces lsp_signature.nvim.
		signature = {
			enabled = true,
			window = { border = "rounded" },
		},
		-- Cmdline completion keeps being handled by wilder.nvim.
		cmdline = { enabled = false },
	})
end
