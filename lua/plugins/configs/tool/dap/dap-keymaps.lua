local M = {}

local map = require("helper.mapping").map

local did_load_debug_mappings = false

function M.load_extras()
	if not did_load_debug_mappings then
		map("K", "<Cmd>lua require('dapui').eval()<CR>"):mode("nv"):noremap():nowait():desc("dap: Evaluate expression under cursor"):set()
		did_load_debug_mappings = true
	end
end

return M

