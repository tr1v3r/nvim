return function()
	local notify = require("notify")
	local icons = {
		diagnostics = require("r1v3r.icons").get("diagnostics"),
		ui = require("r1v3r.icons").get("ui"),
	}

	-- local hl = vim.api.nvim_get_hl(0, { name = "NotifyBackground" })
	-- if not hl.bg then
	-- 	vim.api.nvim_set_hl(0, "NotifyBackground", { bg = "#403e41" })
	-- end

	notify.setup({
		---@usage Animation style one of { "fade", "slide", "fade_in_slide_out", "static" }
		stages = "fade_in_slide_out",
		---@usage Function called when a new window is opened, use for changing win settings/config
		on_open = function(win)
			-- vim.api.nvim_set_option_vale("winblend", 0, { scope = "local", win = win })
			vim.api.nvim_win_set_config(win, { zindex = 90 })
		end,
		---@usage Function called when a window is closed
		on_close = nil,
		---@usage timeout for notifications in ms, default 5000
		timeout = 2000,
		-- @usage User render fps value
		fps = 20,
		-- Render function for notifications. See notify-render()
		render = "default",
		---@usage highlight behind the window for stages that change opacity
		background_colour = "#403e41",
		-- background_colour = "NotifyBackground",
		---@usage minimum width for notification windows
		minimum_width = 50,
		---@usage notifications with level lower than this would be ignored. [ERROR > WARN > INFO > DEBUG > TRACE]
		level = "INFO",
		---@usage Icons for the different levels
		icons = {
			ERROR = icons.diagnostics.Error,
			WARN = icons.diagnostics.Warning,
			INFO = icons.diagnostics.Information,
			DEBUG = icons.ui.Bug,
			TRACE = icons.ui.Pencil,
		},
	})

	vim.notify = notify
end
