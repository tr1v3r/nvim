-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#go
-- https://github.com/golang/vscode-go/blob/master/docs/debugging.md
-- https://github.com/leoluz/nvim-dap-go#nvim-dap-go
return function()
	local dap = require("dap")
	local helper = require("helper.dap")

	require("dap-go").setup()

	dap.configurations.go = {
		{
			type = "go",
			name = "Debug (project)",
			request = "launch",
			cwd = "${workspaceFolder}",
			program = "${workspaceFolder}",
			console = "integratedTerminal",
			dlvToolPath = vim.fn.exepath("dlv"),
			showLog = true,
			showRegisters = true,
			stopOnEntry = false,
		},
		{
			type = "go",
			name = "Debug (project with args)",
			request = "launch",
			cwd = "${workspaceFolder}",
			program = "${workspaceFolder}",
			args = helper.input_args(),
			console = "integratedTerminal",
			dlvToolPath = vim.fn.exepath("dlv"),
			showLog = true,
			showRegisters = true,
			stopOnEntry = false,
		},
		{
			type = "go",
			name = "Debug (file)",
			request = "launch",
			cwd = "${workspaceFolder}",
			program = helper.input_file_path(),
			console = "integratedTerminal",
			dlvToolPath = vim.fn.exepath("dlv"),
			showLog = true,
			showRegisters = true,
			stopOnEntry = false,
		},
		{
			type = "go",
			name = "Debug (file with args)",
			request = "launch",
			cwd = "${workspaceFolder}",
			program = helper.input_file_path(),
			args = helper.input_args(),
			console = "integratedTerminal",
			dlvToolPath = vim.fn.exepath("dlv"),
			showLog = true,
			showRegisters = true,
			stopOnEntry = false,
		},
		{
			type = "go",
			name = "Debug (executable)",
			request = "launch",
			cwd = "${workspaceFolder}",
			program = helper.input_exec_path(),
			args = helper.input_args(),
			console = "integratedTerminal",
			dlvToolPath = vim.fn.exepath("dlv"),
			mode = "exec",
			showLog = true,
			showRegisters = true,
			stopOnEntry = false,
		},
		{
			type = "go",
			name = "Debug (test file)",
			request = "launch",
			cwd = "${workspaceFolder}",
			program = helper.input_file_path(),
			console = "integratedTerminal",
			dlvToolPath = vim.fn.exepath("dlv"),
			mode = "test",
			showLog = true,
			showRegisters = true,
			stopOnEntry = false,
		},
		{
			type = "go",
			name = "Debug (using go.mod)",
			request = "launch",
			cwd = "${workspaceFolder}",
			program = "./${relativeFileDirname}",
			console = "integratedTerminal",
			dlvToolPath = vim.fn.exepath("dlv"),
			mode = "test",
			showLog = true,
			showRegisters = true,
			stopOnEntry = false,
		},
		-- {
		-- 	type = "go",
		-- 	name = "Attach remote",
		-- 	mode = "remote",
		-- 	request = "attach",
		-- },
	}
end

-- return function()
-- 	local dap = require("dap")
-- 	local helper = require("helper.dap")

-- 	if not require("mason-registry").is_installed("go-debug-adapter") then
-- 		vim.notify(
-- 			"Automatically installing `go-debug-adapter` for go debugging",
-- 			vim.log.levels.INFO,
-- 			{ title = "nvim-dap" }
-- 		)

-- 		local go_dbg = require("mason-registry").get_package("go-debug-adapter")
-- 		go_dbg:install():once(
-- 			"closed",
-- 			vim.schedule_wrap(function()
-- 				if go_dbg:is_installed() then
-- 					vim.notify("Successfully installed `go-debug-adapter`", vim.log.levels.INFO, { title = "nvim-dap" })
-- 				end
-- 			end)
-- 		)
-- 	end

-- 	dap.adapters.go = {
-- 		type = "executable",
-- 		command = "node",
-- 		args = {
-- 			require("mason-registry").get_package("go-debug-adapter"):get_install_path()
-- 				.. "/extension/dist/debugAdapter.js",
-- 		},
-- 	}
-- 	dap.configurations.go = {
-- 		{
-- 			type = "go",
-- 			name = "Debug (file)",
-- 			request = "launch",
-- 			cwd = "${workspaceFolder}",
-- 			program = helper.input_file_path(),
-- 			console = "integratedTerminal",
-- 			dlvToolPath = vim.fn.exepath("dlv"),
-- 			showLog = true,
-- 			showRegisters = true,
-- 			stopOnEntry = false,
-- 		},
-- 		{
-- 			type = "go",
-- 			name = "Debug (file with args)",
-- 			request = "launch",
-- 			cwd = "${workspaceFolder}",
-- 			program = helper.input_file_path(),
-- 			args = helper.input_args(),
-- 			console = "integratedTerminal",
-- 			dlvToolPath = vim.fn.exepath("dlv"),
-- 			showLog = true,
-- 			showRegisters = true,
-- 			stopOnEntry = false,
-- 		},
-- 		{
-- 			type = "go",
-- 			name = "Debug (executable)",
-- 			request = "launch",
-- 			cwd = "${workspaceFolder}",
-- 			program = helper.input_exec_path(),
-- 			args = helper.input_args(),
-- 			console = "integratedTerminal",
-- 			dlvToolPath = vim.fn.exepath("dlv"),
-- 			mode = "exec",
-- 			showLog = true,
-- 			showRegisters = true,
-- 			stopOnEntry = false,
-- 		},
-- 		{
-- 			type = "go",
-- 			name = "Debug (test file)",
-- 			request = "launch",
-- 			cwd = "${workspaceFolder}",
-- 			program = helper.input_file_path(),
-- 			console = "integratedTerminal",
-- 			dlvToolPath = vim.fn.exepath("dlv"),
-- 			mode = "test",
-- 			showLog = true,
-- 			showRegisters = true,
-- 			stopOnEntry = false,
-- 		},
-- 		{
-- 			type = "go",
-- 			name = "Debug (using go.mod)",
-- 			request = "launch",
-- 			cwd = "${workspaceFolder}",
-- 			program = "./${relativeFileDirname}",
-- 			console = "integratedTerminal",
-- 			dlvToolPath = vim.fn.exepath("dlv"),
-- 			mode = "test",
-- 			showLog = true,
-- 			showRegisters = true,
-- 			stopOnEntry = false,
-- 		},
-- 	}
-- end
