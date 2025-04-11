return function()
	-- Make Ranger replace Netrw and be the file explorer
	vim.g.rnvimr_enable_ex = 1
	-- Make Ranger to be hidden after picking a file
	vim.g.rnvimr_enable_picker = 1.0
	-- Replace `$EDITOR` candidate with this command to open the selected file
	vim.g.rnvimr_edit_cmd = "drop"
	-- Disable a border for floating window
	vim.g.rnvimr_draw_border = 0
	-- Hide the files included in gitignore
	vim.g.rnvimr_hide_gitignore = 1
	-- Change the border's color
	vim.g.rnvimr_border_attr = { fg = -1, bg = -1 }
	-- Make Neovim wipe the buffers corresponding to the files deleted by Ranger
	vim.g.rnvimr_enable_bw = 1
	-- Add a shadow window, value is equal to 100 will disable shadow
	vim.g.rnvimr_shadow_winblend = 70
	-- Draw border with both
	-- vim.g.rnvimr_ranger_cmd = {'ranger', '--cmd=set draw_borders both'}

	-- Link CursorLine into RnvimrNormal highlight in the Floating window
	vim.cmd([[highlight link RnvimrNormal CursorLine]])

	-- vim.g.rnvimr_action = {
	-- 	['<C-t>'] = 'NvimEdit tabedit',
	-- 	['<C-x>'] = 'NvimEdit split',
	-- 	['<C-v>'] = 'NvimEdit vsplit',
	-- 	gw = 'JumpNvimCwd',
	-- 	yw = 'EmitRangerCwd'
	-- }

	-- vim.g.rnvimr_layout = {
	-- 	relative = 'editor',
	-- 	width = vim.o.columns,
	-- 	height = vim.o.lines,
	-- 	col = 0,
	-- 	row = 0,
	-- 	style = 'minimal'
	-- }
	-- vim.cmd[[let g:rnvimr_layout={'relative': 'editor', 'width': 100, 'height': 100, 'col': 0, 'row': 0, 'style': 'minimal'}]]

	local function round(x)
		return x >= 0 and math.floor(x + 0.5) or math.ceil(x - 0.5)
	end
	vim.g.rnvimr_layout = {
		relative = "editor",
		width = math.floor(round(0.7 * vim.o.columns)),
		height = math.floor(round(0.7 * vim.o.lines)),
		col = math.floor(round(0.15 * vim.o.columns)),
		row = math.floor(round(0.15 * vim.o.lines)),
		style = "minimal",
	}

	-- vim.g.rnvimr_presets = {
	-- 	{width = 1.0, height = 1.0}
	-- }
end

-- kelly-lin/ranger.nvim config
-- local ranger = require("ranger-nvim")
-- ranger.setup({
-- 	replace_netrw = false, -- useless, unknown bug
-- 	enable_cmds = true,
-- 	keybinds = {
-- 		["ov"] = ranger.OPEN_MODE.vsplit,
-- 		["oh"] = ranger.OPEN_MODE.split,
-- 		["ot"] = ranger.OPEN_MODE.tabedit,
-- 		["or"] = ranger.OPEN_MODE.rifle
-- 	}
-- })
