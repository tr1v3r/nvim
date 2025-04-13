return function()
	require("helper").gen_lspkind_hl()

	local icons = {
		cmp = require("r1v3r.icons").get("cmp", true),
		diagnostics = require("r1v3r.icons").get("diagnostics", true),
		kind = require("r1v3r.icons").get("kind", true),
		type = require("r1v3r.icons").get("type", true),
		ui = require("r1v3r.icons").get("ui", true),
	}

	local function set_sidebar_icons()
		-- Set icons for sidebar.
		local diagnostic_icons = {
			Error = icons.diagnostics.Error_alt,
			Warn = icons.diagnostics.Warning_alt,
			Info = icons.diagnostics.Information_alt,
			Hint = icons.diagnostics.Hint_alt,
		}
		for type, icon in pairs(diagnostic_icons) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl })
		end
	end

	set_sidebar_icons()

	require("lspsaga").setup({
		-- Scrolling Keymaps: https://nvimdev.github.io/lspsaga/misc/#scrolling-keymaps
		scroll_preview = {
			scroll_down = "e",
			scroll_up = "u",
		},
		request_timeout = 3000,
		-- -- https://dev.neovim.pro/lspsaga/finder/
		-- finder = {
		-- 	silent = true,
		-- 	default = "def+ref+imp",
		-- 	layout = "float",
		-- 	filter = {},
		-- 	keys = {
		-- 		shuttle = "[]",
		-- 		toggle_or_open = "<CR>",
		-- 		jump_to = "i",
		-- 		vsplit = "I",
		-- 		split = "o",
		-- 		tabe = "O",
		-- 		tabenew = "n",
		-- 		quit = "q",
		-- 		close = "<Esc>",
		-- 	},
		-- },
		-- -- https://dev.neovim.pro/lspsaga/definition/
		-- definition = {
		-- 	keys = {
		-- 		edit = "<C-c>o",
		-- 		vsplit = "<C-c>v",
		-- 		split = "<C-c>s",
		-- 		tabe = "<C-c>t",
		-- 		close = "<C-c>q",
		-- 		quit = "q",
		-- 	},
		-- },
		-- Code Action: https://nvimdev.github.io/lspsaga/codeaction/
		code_action = {
			enable = false,
			num_shortcut = true,
			only_in_cursor = false,
			show_server_name = true,
			extend_gitsigns = false,
			keys = {
				quit = "q",
				exec = "<CR>",
			},
		},
		-- LightBulb: https://nvimdev.github.io/lspsaga/lightbulb/
		lightbulb = {
			enable = false,
			sign = true,
			sign_priority = 20,
			virtual_text = false,
		},
		-- Diagnostics: https://nvimdev.github.io/lspsaga/diagnostic
		diagnostic = {
			max_width = 0.8,
			max_height = 0.6,
			text_hl_follow = true,
			show_code_action = true,
			border_follow = true,
			diagnostic_only_current = false,
			extend_relatedInformation = false,
			jump_num_shortcut = true,
			show_layout = "float",
			keys = {
				exec_action = "r",
				quit = "q",
				toggle_or_jump = "<CR>",
				quit_in_show = { "q", "<Esc>" },
			},
		},
		-- Rename: https://nvimdev.github.io/lspsaga/rename/
		rename = {
			in_select = false,
			auto_save = false,
			keys = {
				quit = "<Esc>",
				select = "x",
				exec = "<CR>",
			},
		},
		-- Hover: https://nvimdev.github.io/lspsaga/hover
		hover = {
			max_width = 0.9,
			max_height = 0.8,
			open_link = "gl",
			open_browser = "silent !" .. require("r1v3r.settings").external_browser,
		},
		-- -- https://dev.neovim.pro/lspsaga/outline/
		-- outline = {
		-- 	win_position = "right",
		-- 	win_width = 30,
		-- 	auto_preview = false,
		-- 	auto_close = true,
		-- 	close_after_jump = true,
		-- 	detail = false,
		-- 	layout = "normal",
		-- 	keys = {
		-- 		toggle_or_jump = "o",
		-- 		jump = 'i',
		-- 		quit = "q",
		-- 	},
		-- },
		-- Breadcrumbs: https://nvimdev.github.io/lspsaga/breadcrumbs/
		symbol_in_winbar = {
			enable = false,
			separator = " " .. icons.ui.Separator,
			hide_keyword = false,
			show_file = false,
			-- folder_level = 2,
			color_mode = true,
		},
		-- Impl: https://nvimdev.github.io/lspsaga/implement/
		implement = {
			enable = true,
			sign = true,
			virtual_text = true,
		},
		-- Callhierarchy: https://nvimdev.github.io/lspsaga/callhierarchy/
		callhierarchy = {
			layout = "float",
			keys = {
				edit = "<CR>",
				vsplit = "v",
				split = "s",
				tabe = "t",
				quit = "q",
				shuttle = "[]",
				toggle_or_req = "o",
				close = "<Esc>",
			},
		},
		-- Beacon: https://nvimdev.github.io/lspsaga/misc/#beacon
		beacon = {
			enable = true,
			frequency = 12,
		},
		-- Generic UI Options: https://nvimdev.github.io/lspsaga/misc/#generic-ui-options
		ui = {
			title = true,
			devicon = true,
			border = "single", -- Can be single, double, rounded, solid, shadow.
			actionfix = icons.ui.Spell,
			expand = icons.ui.ArrowClosed,
			collapse = icons.ui.ArrowOpen,
			code_action = icons.ui.CodeAction,
			lines = { "┗", "┣", "┃", "━", "┏" },
			imp_sign = icons.kind.Implementation,
			kind = {
				-- Kind
				Class = { icons.kind.Class, "LspKindClass" },
				Constant = { icons.kind.Constant, "LspKindConstant" },
				Constructor = { icons.kind.Constructor, "LspKindConstructor" },
				Enum = { icons.kind.Enum, "LspKindEnum" },
				EnumMember = { icons.kind.EnumMember, "LspKindEnumMember" },
				Event = { icons.kind.Event, "LspKindEvent" },
				Field = { icons.kind.Field, "LspKindField" },
				File = { icons.kind.File, "LspKindFile" },
				Function = { icons.kind.Function, "LspKindFunction" },
				Interface = { icons.kind.Interface, "LspKindInterface" },
				Key = { icons.kind.Keyword, "LspKindKey" },
				Method = { icons.kind.Method, "LspKindMethod" },
				Module = { icons.kind.Module, "LspKindModule" },
				Namespace = { icons.kind.Namespace, "LspKindNamespace" },
				Number = { icons.kind.Number, "LspKindNumber" },
				Operator = { icons.kind.Operator, "LspKindOperator" },
				Package = { icons.kind.Package, "LspKindPackage" },
				Property = { icons.kind.Property, "LspKindProperty" },
				Struct = { icons.kind.Struct, "LspKindStruct" },
				TypeParameter = { icons.kind.TypeParameter, "LspKindTypeParameter" },
				Variable = { icons.kind.Variable, "LspKindVariable" },
				-- Type
				Array = { icons.type.Array, "LspKindArray" },
				Boolean = { icons.type.Boolean, "LspKindBoolean" },
				Null = { icons.type.Null, "LspKindNull" },
				Object = { icons.type.Object, "LspKindObject" },
				String = { icons.type.String, "LspKindString" },
				-- ccls-specific icons.
				TypeAlias = { icons.kind.TypeAlias, "LspKindTypeAlias" },
				Parameter = { icons.kind.Parameter, "LspKindParameter" },
				StaticMethod = { icons.kind.StaticMethod, "LspKindStaticMethod" },
				-- Microsoft-specific icons.
				Text = { icons.kind.Text, "LspKindText" },
				Snippet = { icons.kind.Snippet, "LspKindSnippet" },
				Folder = { icons.kind.Folder, "LspKindFolder" },
				Unit = { icons.kind.Unit, "LspKindUnit" },
				Value = { icons.kind.Value, "LspKindValue" },
			},
		},
	})
end
