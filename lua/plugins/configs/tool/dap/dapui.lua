return function()
	local icons = {
		ui = require("r1v3r.icons").get("ui"),
		dap = require("r1v3r.icons").get("dap"),
	}

	require("dapui").setup({
		force_buffers = true,
		icons = {
			expanded = icons.ui.ArrowOpen,
			collapsed = icons.ui.ArrowClosed,
			current_frame = icons.ui.Indicator,
		},
		mappings = {
			-- Use a table to apply multiple mappings
			expand = { "<CR>", "<2-LeftMouse>" },
			open = "o",
			remove = "d",
			edit = "k",
			repl = "r",
			toggle = "t",
		},
		layouts = {
			{
				elements = {
					-- Provide as ID strings or tables with "id" and "size" keys
					{
						id = "scopes",
						size = 0.3, -- Can be float or integer > 1
					},
					{ id = "breakpoints", size = 0.1 },
					{ id = "watches", size = 0.3 },
					{ id = "stacks", size = 0.3 },
				},
				size = 0.3,
				position = "left",
			},
			{
				elements = {
					{ id = "repl", size = 0.55 },
					{ id = "console", size = 0.45 },
				},
				size = 0.25,
				position = "bottom",
			},
		},
		-- Requires Nvim version >= 0.8
		controls = {
			enabled = true,
			-- Display controls in this session
			element = "repl",
			icons = {
				pause = icons.dap.Pause,
				play = icons.dap.Play,
				step_into = icons.dap.StepInto,
				step_over = icons.dap.StepOver,
				step_out = icons.dap.StepOut,
				step_back = icons.dap.StepBack,
				run_last = icons.dap.RunLast,
				terminate = icons.dap.Terminate,
			},
		},
		floating = {
			max_height = nil,
			max_width = nil,
			border = "single",
			mappings = { close = { "q", "<Esc>" } },
		},
		render = { indent = 1, max_value_lines = 85 },
	})
end
