_G._command_panel = function()
	require("telescope.builtin").keymaps({
		lhs_filter = function(lhs)
			return not string.find(lhs, "Þ")
		end,
		layout_config = {
			width = 0.8,
			height = 0.8,
			prompt_position = "top",
		},
	})
end

local _lazygit = nil
_G._open_lazygit = function()
	if vim.fn.executable("lazygit") == 1 then
		if not _lazygit then
			require("helper").float_terminal("lazygit")
			-- _lazygit = require("toggleterm.terminal").Terminal:new({
			-- 	cmd = "lazygit",
			-- 	direction = "float",
			-- 	close_on_exit = true,
			-- 	hidden = true,
			-- })
		end
		-- _lazygit:toggle()
	else
		vim.notify("Command [lazygit] not found!", vim.log.levels.ERROR, {
			title = "Command not found",
		})
	end
end

_G._flash_esc_or_noh = function()
	local flash_active, state = pcall(function()
		return require("flash.plugins.char").state
	end)
	if flash_active and state and state.visible then
		state:hide()
	else
		vim.cmd.noh()
	end
end
