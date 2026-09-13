local completion = {}
local settings = require("r1v3r.settings")
local use_copilot = settings.use_copilot

-- Completion engine, replaces nvim-cmp and its source plugins.
-- Docs: https://cmp.saghen.dev
completion["saghen/blink.cmp"] = {
	lazy = true,
	-- Load on the first buffer: the LSP bootstrap (see `event.lua`) calls
	-- `get_lsp_capabilities()` before servers attach to that buffer.
	event = { "BufReadPre", "BufNewFile" },
	-- Stay on the stable v1 line; v2 (main) needs `blink.lib` and is a moving target.
	version = "1.*",
	config = require("completion.blink"),
	dependencies = {
		{
			"L3MON4D3/LuaSnip",
			version = "v2.*",
			dependencies = { "rafamadriz/friendly-snippets" },
			config = require("completion.luasnip"),
		},
		-- nvim-cmp source compatibility layer (v2.* pairs with blink.cmp v1.*)
		{ "saghen/blink.compat", version = "2.*", lazy = true, opts = {} },
		-- Keep the spec present when disabled so lockfile updates do not remove it.
		{ "giuxtaposition/blink-cmp-copilot", enabled = use_copilot },
	},
}
completion["kdheepak/cmp-latex-symbols"] = {
	lazy = true,
	ft = { "plaintex", "tex" },
}

completion["dnlhc/glance.nvim"] = {
	lazy = true,
	event = "LspAttach",
	config = require("completion.glance"),
}
-- Neovim plugin for a code outline window
completion["stevearc/aerial.nvim"] = {
	lazy = true,
	event = "LspAttach",
	config = require("completion.aerial"),
}
completion["joechrisellis/lsp-format-modifications.nvim"] = {
	lazy = true,
	event = "LspAttach",
}
completion["nvimtools/none-ls.nvim"] = {
	lazy = true,
	ft = require("completion.none-ls-sources").filetypes(settings.null_ls_deps),
	config = require("completion.null-ls"),
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
}
completion["zbirenbaum/copilot.lua"] = {
	enabled = use_copilot,
	lazy = true,
	cmd = "Copilot",
	event = "InsertEnter",
	config = require("completion.copilot"),
}

return completion
