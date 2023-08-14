local M = {}

local map = require("helper.mapping").map

local did_load_debug_mappings = false

function M.load_extras()
	if not did_load_debug_mappings then
		map("W", "lua require('dapui').eval()"):mode("nv"):Cmd():noremap():nowait():desc("dap: Evaluate expression under cursor"):set()
		did_load_debug_mappings = true
	end
end

return M

