return function()
	local icons = { ui = require("r1v3r.icons").get("ui", true) }
	local lga_actions = require("telescope-live-grep-args.actions")
	local telescope = require("telescope")
	local actions = require("telescope.actions")

	telescope.setup({
		defaults = {
			mappings = {
				-- below is default keymaps
				-- `<c-v>`: opens a diff in a vertical split
				-- `<c-x>`: opens a diff in a horizontal split
				-- `<c-t>`: opens a diff in a new tab
				-- ["<C-v>"] = actions.select_vertical,
				-- ["<C-x>"] = actions.select_horizontal,
				-- ["<C-t>"] = actions.select_tab,
				n = {
					["u"] = actions.move_selection_previous,
					["e"] = actions.move_selection_next,
					["U"] = actions.preview_scrolling_up,
					["E"] = actions.preview_scrolling_down,
					["N"] = actions.preview_scrolling_left,
					["I"] = actions.preview_scrolling_right,

					["<C-d>"] = false,
					["<C-e>"] = actions.preview_scrolling_down,
					["<C-n>"] = actions.preview_scrolling_left,
					["<C-i>"] = actions.preview_scrolling_right,

					["q"] = actions.close,
				},
				i = {
					["<C-d>"] = false,
					["<C-e>"] = actions.preview_scrolling_down,
					["<C-n>"] = actions.preview_scrolling_left,
					["<C-i>"] = actions.preview_scrolling_right,
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
			initial_mode = "insert",
			prompt_prefix = " " .. icons.ui.Telescope .. " ",
			selection_caret = icons.ui.ChevronRight,
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
					preview_width = 0.55,
					results_width = 0.8,
				},
				vertical = {
					mirror = false,
				},
				width = 0.85,
				height = 0.92,
				preview_cutoff = 120,
			},
			file_previewer = require("telescope.previewers").vim_buffer_cat.new,
			grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
			qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
			file_sorter = require("telescope.sorters").get_fuzzy_file,
			generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
			buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
		},
		extensions = {
			aerial = {
				show_lines = false,
				show_nesting = {
					["_"] = false, -- This key will be the default
					lua = true, -- You can set the option for specific filetypes
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
end
