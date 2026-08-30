return function()
	-- set indent colorscheme
	local highlight = {
		"RainbowRed",
		"RainbowYellow",
		"RainbowBlue",
		"RainbowOrange",
		"RainbowGreen",
		"RainbowViolet",
		"RainbowCyan",
	}
	local hooks = require("ibl.hooks")
	-- create the highlight groups in the highlight setup hook, so they are reset
	-- every time the colorscheme changes
	hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
		local c = require("helper").get_palette()
		vim.api.nvim_set_hl(0, "RainbowRed", { fg = c.red })
		vim.api.nvim_set_hl(0, "RainbowYellow", { fg = c.yellow })
		vim.api.nvim_set_hl(0, "RainbowBlue", { fg = c.blue })
		vim.api.nvim_set_hl(0, "RainbowOrange", { fg = c.peach })
		vim.api.nvim_set_hl(0, "RainbowGreen", { fg = c.green })
		vim.api.nvim_set_hl(0, "RainbowViolet", { fg = c.mauve })
		vim.api.nvim_set_hl(0, "RainbowCyan", { fg = c.teal })
	end)

	require("ibl").setup({
		enabled = true,
		debounce = 200,
		indent = {
			char = "│",
			tab_char = "│",
			smart_indent_cap = true,
			priority = 2,
			highlight = highlight,
		},
		whitespace = { remove_blankline_trail = true },
		-- Note: The `scope` field requires treesitter to be set up
		scope = {
			enabled = true,
			char = "┃",
			-- char = "▌",
			highlight = highlight,
			show_start = false,
			show_end = false,
			injected_languages = true,
			priority = 1000,
			include = {
				node_type = {
					["*"] = {
						"argument_list",
						"arguments",
						"assignment_statement",
						"Block",
						"chunk",
						"class",
						"ContainerDecl",
						"dictionary",
						"do_block",
						"do_statement",
						"element",
						"except",
						"FnCallArguments",
						"for",
						"for_statement",
						"function",
						"function_declaration",
						"function_definition",
						"if_statement",
						"IfExpr",
						"IfStatement",
						"import",
						"InitList",
						"list_literal",
						"method",
						"object",
						"ParamDeclList",
						"repeat_statement",
						"selector",
						"SwitchExpr",
						"table",
						"table_constructor",
						"try",
						"tuple",
						"type",
						"var",
						"while",
						"while_statement",
						"with",
					},
				},
			},
		},
		exclude = {
			filetypes = {
				"", -- for all buffers without a file type
				"aerial",
				"alpha",
				"bigfile",
				"dashboard",
				"dotooagenda",
				"flutterToolsOutline",
				"fugitive",
				"git",
				"gitcommit",
				"help",
				"json",
				"log",
				"markdown",
				"NvimTree",
				"peekaboo",
				"startify",
				"TelescopePrompt",
				"todoist",
				"txt",
				"undotree",
				"vimwiki",
				"vista",
			},
			buftypes = { "terminal", "nofile", "quickfix", "prompt" },
		},
	})
end
