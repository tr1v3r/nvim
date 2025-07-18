return function()
	local icons = { ui = require("r1v3r.icons").get("ui", true) }
	local lga_actions = require("telescope-live-grep-args.actions")
	local telescope = require("telescope")
	local actions = require("telescope.actions")

	-- check if rg exists
	if vim.fn.executable("rg") == 0 then
		vim.notify(
			"Ripgrep (rg) is not installed.\nPlease install it to use live grep feature.",
			vim.log.levels.ERROR,
			{ title = "Dependency missing" }
		)
	end

	telescope.setup({
		defaults = {
			initial_mode = "insert",
			prompt_prefix = " " .. icons.ui.Telescope .. " ",
			selection_caret = icons.ui.HandPointRight,
			mappings = {
				-- below is default keymaps
				-- `<c-v>`: opens a diff in a vertical split
				-- `<c-x>`: opens a diff in a horizontal split
				-- `<c-t>`: opens a diff in a new tab
				-- ["<C-v>"] = actions.select_vertical,
				-- ["<C-x>"] = actions.select_horizontal,
				-- ["<C-t>"] = actions.select_tab,
				i = {
					["<A-u>"] = actions.cycle_history_prev,
					["<A-e>"] = actions.cycle_history_next,

					["<C-d>"] = false,
					["<C-u>"] = actions.preview_scrolling_up,
					["<C-e>"] = actions.preview_scrolling_down,
					["<C-n>"] = actions.preview_scrolling_left,
					["<C-i>"] = actions.preview_scrolling_right,
				},
				n = {
					["u"] = actions.move_selection_previous,
					["e"] = actions.move_selection_next,
					["U"] = actions.preview_scrolling_up,
					["E"] = actions.preview_scrolling_down,
					["N"] = actions.preview_scrolling_left,
					["I"] = actions.preview_scrolling_right,

					["<C-d>"] = false,
					["<C-u>"] = actions.preview_scrolling_up,
					["<C-e>"] = actions.preview_scrolling_down,
					["<C-n>"] = actions.preview_scrolling_left,
					["<C-i>"] = actions.preview_scrolling_right,

					["q"] = actions.close,
				},
			},
			vimgrep_arguments = {
				"rg",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--smart-case",
			},
			scroll_strategy = "limit",
			results_title = false,
			layout_strategy = "horizontal",
			path_display = { "absolute" },
			selection_strategy = "reset",
			sorting_strategy = "ascending",
			color_devicons = true,
			file_ignore_patterns = { ".git/", ".cache", "build/", "%.class", "%.pdf", "%.mkv", "%.mp4", "%.zip" },
			layout_config = {
				horizontal = {
					prompt_position = "top",
					-- preview_width = 0.45,
					-- results_width = 0.8,
				},
				vertical = {
					mirror = false,
				},
				width = vim.o.columns > 100 and 0.85 or 0.6,
				height = vim.o.lines > 40 and 0.92 or 0.7,
				preview_cutoff = 120,
			},
			file_previewer = require("telescope.previewers").vim_buffer_cat.new,
			grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
			qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
			file_sorter = require("telescope.sorters").get_fuzzy_file,
			generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
			buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
		},
		pickers = {
			buffers = {
				sort_mru = true, -- 最近使用的缓冲区排在前面
				select_current = true,
				mappings = {
					i = {
						["<C-d>"] = actions.delete_buffer,
					},
					n = {
						["dd"] = actions.delete_buffer,
					},
				},
			},
		},
		extensions = {
			aerial = {
				-- Set the width of the first two columns (the second
				-- is relevant only when show_columns is set to 'both')
				col1_width = 2,
				col2_width = 30,
				-- How to format the symbols
				format_symbol = function(symbol_path, filetype)
					-- 不同文件类型的自定义格式
					local formatters = {
						json = function(path)
							return table.concat(path, ".")
						end,

						yaml = function(path)
							return table.concat(path, ".")
						end,

						lua = function(path)
							-- 显示模块.函数格式
							if #path > 1 then
								return table.concat({ path[1], path[#path] }, ".")
							end
							return path[#path]
						end,

						go = function(path)
							-- 处理方法：只显示方法名，添加简短的接收器标识
							local symbol_name = path[#path]

							local method_name, receiver_type, is_pointer, type_name

							if symbol_name:match("^%(.*%)%s+(.+)") then -- 格式1: (s *HandleServer) Run (treesitter)
								local receiver = symbol_name:match("^%((.-)%)")
								method_name = symbol_name:match("^%(.*%)%s+(.+)")

								if receiver then
									receiver_type = receiver:match("([^%s]+)$") or receiver
									is_pointer = receiver_type:match("^%*") ~= nil
									type_name = receiver_type:gsub("^%*", "")
								end
							elseif symbol_name:match("^%((.-)%)%.(.+)") then -- 格式2: (*HandleServer).Run (lsp)
								receiver_type = symbol_name:match("^%((.-)%)%.(.+)")
								method_name = symbol_name:match("^%(.-%)%.(.+)")

								if receiver_type then
									is_pointer = receiver_type:match("^%*") ~= nil
									type_name = receiver_type:gsub("^%*", "")
								end
							else
								return symbol_name
							end

							-- 统一处理接收器标识
							local receiver_initial = ""
							if type_name then
								receiver_initial = type_name:sub(1, 1):upper()
								if is_pointer then
									receiver_initial = "*" .. receiver_initial
								end
							end

							return string.format("%s.%s", receiver_initial, method_name)
						end,

						python = function(path)
							-- 显示类.方法，但限制长度
							local result = #path > 1 and table.concat({ path[#path - 1], path[#path] }, ".")
								or path[#path]
							return #result > 50 and (result:sub(1, 47) .. "...") or result
						end,

						javascript = function(path)
							-- 显示最后两级
							if #path > 1 then
								return table.concat({ path[#path - 1], path[#path] }, ".")
							end
							return path[#path]
						end,
					}

					local formatter = formatters[filetype] or function(path)
						return path[#path]
					end
					return formatter(symbol_path)
				end,
				-- Available modes: symbols, lines, both
				show_columns = "both",
				-- show_lines = false,
				show_nesting = {
					["_"] = false, -- This key will be the default
					lua = true, -- You can set the option for specific filetypes
					go = true,
				},
			},
			fzf = {
				fuzzy = false,
				override_generic_sorter = true,
				override_file_sorter = true,
				case_mode = "smart_case",
			},
			frecency = {
				use_sqlite = false,
				show_scores = true,
				show_unindexed = true,
				ignore_patterns = { "*.git/*", "*/tmp/*" },
			},
			live_grep_args = {
				auto_quoting = true, -- enable/disable auto-quoting
				-- define mappings, e.g.
				mappings = { -- extend mappings
					i = {
						["<C-k>"] = lga_actions.quote_prompt(),
						["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
					},
				},
			},
			undo = {
				side_by_side = true,
				mappings = { -- this whole table is the default
					i = {
						-- IMPORTANT: Note that telescope-undo must be available when telescope is configured if
						-- you want to use the following actions. This means installing as a dependency of
						-- telescope in it's `requirements` and loading this extension from there instead of
						-- having the separate plugin definition as outlined above. See issue #6.
						["<cr>"] = require("telescope-undo.actions").yank_additions,
						["<S-cr>"] = require("telescope-undo.actions").yank_deletions,
						["<C-cr>"] = require("telescope-undo.actions").restore,
					},
				},
			},
		},
	})

	telescope.load_extension("frecency")
	telescope.load_extension("fzf")
	telescope.load_extension("live_grep_args")
	telescope.load_extension("notify")
	telescope.load_extension("projects")
	telescope.load_extension("undo")
	telescope.load_extension("zoxide")
	telescope.load_extension("persisted")
	telescope.load_extension("aerial")
	telescope.load_extension("notify")
end
