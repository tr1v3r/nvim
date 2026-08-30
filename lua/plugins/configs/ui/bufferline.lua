return function()
	local icons = { ui = require("r1v3r.icons").get("ui") }
	local filter_filetypes = {
		"aerial",
		"help",
		"terminal",
		"NvimTree",
		"TelescopePrompt",
		"lazy",
		"Glance",
	}

	local opts = {
		options = {
			mode = "tabs", -- set to "buffers" to only show bufferpages instead
			number = nil,
			close_command = "BufDel! %d",
			right_mouse_command = "BufDel! %d",
			modified_icon = icons.ui.Modified,
			buffer_close_icon = icons.ui.Close,
			left_trunc_marker = icons.ui.Left,
			right_trunc_marker = icons.ui.Right,
			max_name_length = 20,
			max_prefix_length = 13,
			tab_size = 20,
			color_icons = true,
			show_buffer_icons = true,
			show_buffer_close_icons = false,
			show_close_icon = true,
			show_tab_indicators = true,
			enforce_regular_tabs = false,
			persist_buffer_sort = true,
			always_show_bufferline = false,
			separator_style = "thin", -- slant/padded_slant/slope/padded_slope/thick/thin
			diagnostics = "nvim_lsp",
			diagnostics_indicator = function(count)
				return "(" .. count .. ")"
			end,
			offsets = {
				{
					filetype = "NvimTree",
					text = "File Explorer",
					text_align = "center",
					padding = 0,
				},
				{
					filetype = "aerial",
					text = "Symbol Outline",
					text_align = "center",
					padding = 0,
				},
			},
			-- https://github.com/akinsho/bufferline.nvim/blob/main/doc/bufferline.txt#L486
			custom_filter = function(buf, _) -- second should be buf_nums
				local ft = vim.bo[buf].filetype
				-- vim.print("current filetype: " .. ft)

				for _, filetype in ipairs(filter_filetypes) do
					if ft == filetype then
						return false
					end
				end
				return true
			end,
		},
		-- Change bufferline's highlights here! See `:h bufferline-highlights` for detailed explanation.
		-- Note: If you use catppuccin then modify the colors below!
		highlights = {},
	}

	if vim.g.colors_name:find("catppuccin") then
		local cp = require("helper").get_palette() -- Get the palette.

		local catppuccin_hl_overwrite = {
			highlights = require("catppuccin.groups.integrations.bufferline").get({
				styles = { "italic", "bold" },
				custom = {
					all = {
						-- Hint
						hint = { fg = cp.rosewater },
						hint_visible = { fg = cp.rosewater },
						hint_selected = { fg = cp.rosewater },
						hint_diagnostic = { fg = cp.rosewater },
						hint_diagnostic_visible = { fg = cp.rosewater },
						hint_diagnostic_selected = { fg = cp.rosewater },
					},
				},
			}),
		}

		opts = vim.tbl_deep_extend("force", opts, catppuccin_hl_overwrite)
	else
		-- Follow the universal palette (e.g. tokyonight) for non-catppuccin colorschemes.
		local c = require("helper").get_palette()
		local sep_fg = c.surface1

		local palette_hl = {
			highlights = {
				fill = { fg = c.subtext0, bg = c.base },
				background = { fg = c.subtext0, bg = c.base },
				tab = { fg = c.subtext0, bg = c.surface0 },
				tab_selected = { fg = c.text, bg = c.base, bold = true },
				tab_close = { fg = c.red, bg = c.base },
				close_button = { fg = c.subtext0, bg = c.base },
				close_button_visible = { fg = c.subtext0, bg = c.base },
				close_button_selected = { fg = c.red, bg = c.base },
				buffer = { fg = c.subtext0, bg = c.base },
				buffer_visible = { fg = c.subtext0, bg = c.base },
				buffer_selected = { fg = c.text, bg = c.base, bold = true, italic = true },
				modified = { fg = c.green, bg = c.base },
				modified_visible = { fg = c.green, bg = c.base },
				modified_selected = { fg = c.green, bg = c.base },
				duplicate_selected = { fg = c.text, bg = c.base, italic = true },
				duplicate_visible = { fg = c.subtext0, bg = c.base, italic = true },
				duplicate = { fg = c.subtext0, bg = c.base, italic = true },
				separator = { fg = sep_fg, bg = c.base },
				separator_visible = { fg = sep_fg, bg = c.base },
				separator_selected = { fg = c.blue, bg = c.base },
				indicator_selected = { fg = c.blue, bg = c.base, bold = true },
				offset_separator = { fg = c.overlay0, bg = c.base },
			},
		}

		opts = vim.tbl_deep_extend("force", opts, palette_hl)
	end

	require("bufferline").setup(opts)
end
