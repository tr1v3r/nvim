-- https://github.com/mfussenegger/nvim-dap/wiki/C-C---Rust-(via--codelldb)
return function()
	local dap = require("dap")
	local helper = require("helper.dap")

	-- should be loaded after LspAttach, so vim notify can be used
	local codelldb_path = vim.fn.exepath("codelldb") -- Find codelldb on $PATH
	if codelldb_path == "" then
		vim.notify("codelldb not found", vim.log.levels.ERROR, { title = "DAP Debuggers" })
		return
	elseif vim.fn.executable(codelldb_path) == 0 then
		vim.notify("codelldb is not executable", vim.log.levels.ERROR, { title = "DAP Debuggers" })
		return
	end

	dap.adapters.codelldb = {
		type = "server",
		port = "${port}",
		executable = {
			command = codelldb_path,
			args = { "--port", "${port}" },
		},
	}
	dap.configurations.c = {
		{
			name = "Debug",
			type = "codelldb",
			request = "launch",
			program = helper.input_exec_path(),
			cwd = "${workspaceFolder}",
			stopOnEntry = false,
			terminal = "integrated",
		},
		{
			name = "Debug (with args)",
			type = "codelldb",
			request = "launch",
			program = helper.input_exec_path(),
			args = helper.input_args(),
			cwd = "${workspaceFolder}",
			stopOnEntry = false,
			terminal = "integrated",
		},
		{
			name = "Attach to a running process",
			type = "codelldb",
			request = "attach",
			program = helper.input_exec_path(),
			stopOnEntry = false,
			waitFor = true,
		},
	}
	dap.configurations.cpp = dap.configurations.c
	dap.configurations.rust = dap.configurations.c
end
