-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#go
-- https://github.com/golang/vscode-go/blob/master/docs/debugging.md
-- https://github.com/leoluz/nvim-dap-go#nvim-dap-go
return function()
	-- local dap = require("dap")
	local helper = require("helper.dap")

	-- if not require("mason-registry").is_installed("go-debug-adapter") then
	-- 	vim.notify(
	-- 		"Automatically installing `go-debug-adapter` for go debugging",
	-- 		vim.log.levels.INFO,
	-- 		{ title = "nvim-dap" }
	-- 	)

	-- 	local go_dbg = require("mason-registry").get_package("go-debug-adapter")
	-- 	go_dbg:install():once(
	-- 		"closed",
	-- 		vim.schedule_wrap(function()
	-- 			if go_dbg:is_installed() then
	-- 				vim.notify("Successfully installed `go-debug-adapter`", vim.log.levels.INFO, { title = "nvim-dap" })
	-- 			end
	-- 		end)
	-- 	)
	-- end

	-- dap.adapters.go = {
	-- 	type = "executable",
	-- 	command = "node",
	-- 	args = {
	-- 		require("mason-registry").get_package("go-debug-adapter"):get_install_path()
	-- 			.. "/extension/dist/debugAdapter.js",
	-- 	},
	-- }

	require("dap-go").setup({
		-- Additional dap configurations can be added.
		-- dap_configurations accepts a list of tables where each entry
		-- represents a dap configuration. For more details do:
		-- :help dap-configuration
		dap_configurations = {
			-- {
			-- Must be "go" or it will be ignored by the plugin
			-- type = "go",
			-- name = "Attach remote",
			-- mode = "remote",
			-- request = "attach",
			-- },
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
		},
		-- delve configurations
		delve = {
			-- the path to the executable dlv which will be used for debugging.
			-- by default, this is the "dlv" executable on your PATH.
			path = "dlv",
			-- time to wait for delve to initialize the debug session.
			-- default to 20 seconds
			initialize_timeout_sec = 20,
			-- a string that defines the port to start delve debugger.
			-- default to string "${port}" which instructs nvim-dap
			-- to start the process in a random available port
			port = "${port}",
			-- additional args to pass to dlv
			args = {},
			-- the build flags that are passed to delve.
			-- defaults to empty string, but can be used to provide flags
			-- such as "-tags=unit" to make sure the test suite is
			-- compiled during debugging, for example.
			-- passing build flags using args is ineffective, as those are
			-- ignored by delve in dap mode.
			build_flags = "",
		},
	})
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
