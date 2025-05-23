return function()
	local colors = require("helper").get_palette()
	local icons = {
		diagnostics = require("r1v3r.icons").get("diagnostics", true),
		git = require("r1v3r.icons").get("git", true),
		git_nosep = require("r1v3r.icons").get("git"),
		misc = require("r1v3r.icons").get("misc", true),
		ui = require("r1v3r.icons").get("ui", true),
	}

	local function custom_theme()
		vim.api.nvim_create_autocmd("ColorScheme", {
			group = vim.api.nvim_create_augroup("LualineColorScheme", { clear = true }),
			pattern = "*",
			callback = function()
				require("lualine").setup({ options = { theme = custom_theme() } })
			end,
		})

		colors = require("helper").get_palette()
		local universal_bg = require("r1v3r.settings").transparent_background and "NONE" or colors.mantle
		return {
			normal = {
				a = { fg = colors.lavender, bg = colors.surface0, gui = "bold" },
				b = { fg = colors.text, bg = universal_bg },
				c = { fg = colors.text, bg = universal_bg },
			},
			command = {
				a = { fg = colors.peach, bg = colors.surface0, gui = "bold" },
			},
			insert = {
				a = { fg = colors.green, bg = colors.surface0, gui = "bold" },
			},
			visual = {
				a = { fg = colors.flamingo, bg = colors.surface0, gui = "bold" },
			},
			terminal = {
				a = { fg = colors.teal, bg = colors.surface0, gui = "bold" },
			},
			replace = {
				a = { fg = colors.red, bg = colors.surface0, gui = "bold" },
			},
			inactive = {
				a = { fg = colors.subtext0, bg = universal_bg, gui = "bold" },
				b = { fg = colors.subtext0, bg = universal_bg },
				c = { fg = colors.subtext0, bg = universal_bg },
			},
		}
	end

	local mini_sections = {
		lualine_a = { "filetype" },
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	}
	local outline = {
		sections = mini_sections,
		filetypes = { "aerial" },
	}
	local diffview = {
		sections = mini_sections,
		filetypes = { "DiffviewFiles" },
	}

	local conditionals = {
		has_enough_room = function()
			return vim.o.columns > 100
		end,
		has_comp_before = function()
			return vim.bo.filetype ~= ""
		end,
		has_git = function()
			local gitdir = vim.fs.find(".git", {
				limit = 1,
				upward = true,
				type = "directory",
				path = vim.fn.expand("%:p:h"),
			})
			return #gitdir > 0
		end,
	}

	---@class lualine_hlgrp
	---@field fg string
	---@field bg string
	---@field gui string?
	local utils = {
		force_centering = function()
			return "%="
		end,
		abbreviate_path = function(path)
			local home = require("r1v3r.global").home
			if path:find(home, 1, true) == 1 then
				path = "~" .. path:sub(#home + 1)
			end
			return path
		end,
		---Generate <func>`color` for any component
		---@param fg string @Foreground hl group
		---@param gen_bg boolean @Generate guibg from hl group |StatusLine|?
		---@param special_nobg boolean @Disable guibg for transparent backgrounds?
		---@param bg string? @Background hl group
		---@param gui string? @GUI highlight arguments
		---@return fun():lualine_hlgrp
		gen_hl = function(fg, gen_bg, special_nobg, bg, gui)
			return function()
				local guifg = colors[fg]
				local guibg = gen_bg and require("helper").hl_to_rgb("StatusLine", true, colors.mantle) or colors[bg]
				local nobg = special_nobg and require("r1v3r.settings").transparent_background
				return {
					fg = guifg and guifg or colors.none,
					bg = (guibg and not nobg) and guibg or colors.none,
					gui = gui and gui or nil,
				}
			end
		end,
	}

	local function diff_source()
		local gitsigns = vim.b.gitsigns_status_dict
		if gitsigns then
			return {
				added = gitsigns.added,
				modified = gitsigns.changed,
				removed = gitsigns.removed,
			}
		end
	end

	local components = {
		separator = { -- use as section separators
			function()
				return "│"
			end,
			padding = 0,
			color = utils.gen_hl("surface1", true, true),
		},

		file_status = {
			function()
				local function is_new_file()
					local filename = vim.fn.expand("%")
					return filename ~= "" and vim.bo.buftype == "" and vim.fn.filereadable(filename) == 0
				end

				local symbols = {}
				if vim.bo.modified then
					table.insert(symbols, "[+]")
				end
				if vim.bo.modifiable == false then
					table.insert(symbols, "[-]")
				end
				if vim.bo.readonly == true then
					table.insert(symbols, "[RO]")
				end
				if is_new_file() then
					table.insert(symbols, "[New]")
				end
				return #symbols > 0 and table.concat(symbols, "") or ""
			end,
			padding = { left = -1, right = 1 },
			cond = conditionals.has_comp_before,
		},

		lsp = {
			function()
				local buf_ft = vim.api.nvim_get_option_value("filetype", { scope = "local" })
				local clients = vim.lsp.get_clients()
				local lsp_lists = {}
				local available_servers = {}
				-- 如果没有活跃的 LSP 客户端，直接返回提示
				if next(clients) == nil then
					return icons.misc.NoActiveLsp -- No server available
				end
				for _, client in ipairs(clients) do
					-- 确保 client.config 存在 filetypes
					---@diagnostic disable-next-line: undefined-field
					local filetypes = client.config and client.config.filetypes or {}
					local client_name = client.name

					-- 检查当前缓冲区的文件类型是否被该 LSP 客户端支持
					if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
						-- Avoid adding servers that already exists.
						if not lsp_lists[client_name] then
							lsp_lists[client_name] = true
							table.insert(available_servers, client_name)
						end
					end
				end
				return next(available_servers) == nil and icons.misc.NoActiveLsp
					or string.format("%s[%s]", icons.misc.LspAvailable, table.concat(available_servers, ", "))
			end,
			color = utils.gen_hl("blue", true, true, nil, "bold"),
			cond = conditionals.has_enough_room,
		},

		python_venv = {
			function()
				local function env_cleanup(venv)
					if string.find(venv, "/") then
						local final_venv = venv
						for w in venv:gmatch("([^/]+)") do
							final_venv = w
						end
						venv = final_venv
					end
					return venv
				end

				if vim.api.nvim_buf_get_option_value("filetype", { scope = "local" }) == "python" then
					local venv = os.getenv("CONDA_DEFAULT_ENV")
					if venv then
						return string.format(icons.misc.PyEnv .. env_cleanup(venv))
					end
					venv = os.getenv("VIRTUAL_ENV")
					if venv then
						return string.format(icons.misc.PyEnv .. env_cleanup(venv))
					end
				end
				return ""
			end,
			color = utils.gen_hl("green", true, true),
			cond = conditionals.has_enough_room,
		},

		tabwidth = {
			function()
				return icons.ui.Tab .. vim.api.nvim_buf_get_option_value("shiftwidth", { scope = "local" })
			end,
			padding = 1,
		},

		cwd = {
			function()
				return icons.ui.FolderWithHeart .. utils.abbreviate_path(vim.fs.normalize(vim.fn.getcwd()))
			end,
			color = utils.gen_hl("subtext0", true, true, nil, "bold"),
		},

		file_location = {
			function()
				local cursorline = vim.fn.line(".")
				local cursorcol = vim.fn.virtcol(".")
				local filelines = vim.fn.line("$")
				local position
				if cursorline == 1 then
					position = "Top"
				elseif cursorline == filelines then
					position = "Bot"
				else
					position = string.format("%2d%%%%", math.floor(cursorline / filelines * 100))
				end
				return string.format("%s · %3d:%-2d", position, cursorline, cursorcol)
			end,
		},

		file_path = {
			function()
				local exclude = {
					-- ["help"] = true,
				}

				if exclude[vim.bo.filetype] then
					return ""
				end

				local path = vim.api.nvim_buf_get_name(0)
				if path == "" then
					return path
				end
				return icons.ui.FileTree
					.. vim
						.fs
						.normalize(path)
						:gsub("^" .. vim.fs.normalize(vim.fn.getcwd()) .. "/", "")
						-- :gsub("/", icons.ui.ArrowClosed)
						:gsub("/", icons.ui.Separator)
				-- :gsub("/", "> ")
			end,
			-- color = utils.gen_hl("blue", true, true, nil, "bold"),
			color = function()
				return { fg = "#61AFEF", gui = "bold" }
			end,
			cond = conditionals.has_enough_room,
		},

		lspsaga_symbols = {
			function()
				local exclude = {
					["terminal"] = true,
					["toggleterm"] = true,
					["prompt"] = true,
					["NvimTree"] = true,
					["help"] = true,
				}
				if vim.api.nvim_win_get_config(0).zindex or exclude[vim.bo.filetype] then
					return "" -- Excluded filetypes
				end

				local symbols = require("lspsaga.symbol.winbar").get_bar()
				if symbols == nil then
					return ""
				end
				return symbols
			end,
		},
	}

	require("lualine").setup({
		options = {
			icons_enabled = true,
			-- theme = "catppuccin",
			theme = custom_theme(),
			disabled_filetypes = {
				"dap-repl",
				"dapui_scopes",
				"dapui_breakpoints",
				"dapui_watches",
				"dapui_stacks",
				"dapui_console",
				statusline = { "alpha" },
				winbar = { "terminal", "toggleterm", "prompt", "NvimTree" },
			},
			component_separators = "",
			section_separators = { left = "", right = "" },
			-- section_separators = { left = "", right = "" },
			refresh = {
				tabline = 1000,
				winbar = 100,
				statusline = 1000,
			},
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = {
				{
					"filetype",
					colored = true,
					icon_only = false,
					icon = { align = "left" },
				},
				components.file_status,
				vim.tbl_extend("force", components.separator, {
					cond = function()
						return conditionals.has_git() and conditionals.has_comp_before()
					end,
				}),
			},
			lualine_c = {
				{
					"branch",
					icon = icons.git_nosep.Branch,
					color = utils.gen_hl("subtext0", true, true, nil, "bold"),
					cond = conditionals.has_git,
				},
				{
					"diff",
					symbols = {
						added = icons.git.Add,
						modified = icons.git.Mod_alt,
						removed = icons.git.Remove,
					},
					source = diff_source,
					colored = false,
					color = utils.gen_hl("subtext0", true, true),
					cond = conditionals.has_git,
					padding = { right = 1 },
				},

				{ utils.force_centering },
				{
					"diagnostics",
					sources = { "nvim_diagnostic" },
					sections = { "error", "warn", "info", "hint" },
					symbols = {
						error = icons.diagnostics.Error,
						warn = icons.diagnostics.Warning,
						info = icons.diagnostics.Information,
						hint = icons.diagnostics.Hint_alt,
					},
				},
				components.lsp,
			},
			lualine_x = {
				{
					"encoding",
					fmt = string.upper,
					padding = { left = 1 },
					cond = conditionals.has_enough_room,
				},
				{
					"fileformat",
					symbols = {
						-- unix = "", -- e712
						-- dos = "", -- e70f
						-- mac = "", -- e71
						unix = "LF",
						dos = "CRLF",
						mac = "CR", -- Legacy macOS
					},
					padding = { left = 1 },
				},
				components.tabwidth,
			},
			lualine_y = {
				components.separator,
				components.python_venv,
				components.cwd,
			},
			lualine_z = { components.file_location },
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = { { "filename", path = 1 } },
			lualine_x = { "location" },
			lualine_y = {},
			lualine_z = {},
		},
		tabline = {},
		-- winbar = { lualine_c = {'filename', path = 1 } }, cannot ignore filetype NvimTree
		winbar = {
			lualine_a = { components.file_path },
			lualine_b = { components.lspsaga_symbols },
		},
		inactive_winbar = { lualine_a = { components.file_path } },
		extensions = {
			"quickfix",
			"nvim-tree",
			"nvim-dap-ui",
			"toggleterm",
			"fugitive",
			outline,
			diffview,
		},
	})
end
