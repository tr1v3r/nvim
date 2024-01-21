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
		vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
		vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
		vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
		vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
		vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
		vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
		vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
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
				"big_file_disabled_ft",
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
