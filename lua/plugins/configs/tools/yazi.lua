local M = {}

M.opts = {
	-- the floating window scaling factor. 1 means 100%, 0.9 means 90%, etc.
	floating_window_scaling_factor = 0.95,
	-- the type of border to use for the floating window. Can be many values,
	-- including 'none', 'rounded', 'single', 'double', 'shadow', etc. For
	-- more information, see :h nvim_open_win
	yazi_floating_window_border = "rounded",
	open_for_directories = true,
	open_multiple_tabs = true,
	keymaps = {
		show_help = "<f1>",
		open_file_in_vertical_split = "<c-v>",
		open_file_in_horizontal_split = "<c-x>",
		open_file_in_tab = "<c-t>",
		grep_in_directory = "<c-f>",
		replace_in_directory = "<c-r>",
		cycle_open_buffers = "<tab>",
		copy_relative_path_to_selected_files = "<c-y>",
		send_to_quickfix_list = "<c-q>",
	},
}

-- 👇 if you use `open_for_directories=true`, this is recommended
M.init = function()
	-- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
	-- vim.g.loaded_netrw = 1
	vim.g.loaded_netrwPlugin = 1
end

return M
