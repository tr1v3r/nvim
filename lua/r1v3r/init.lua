local global = require("r1v3r.global")

-- Create cache dir and data dirs
local createdir = function()
	local data_dir = {
		global.cache_dir .. "backup",
		global.cache_dir .. "undo",
		-- global.cache_dir .. "session",
		-- global.cache_dir .. "swap",
		-- global.cache_dir .. "tags",
	}
	-- Only check whether cache_dir exists, this would be enough.
	if vim.fn.isdirectory(global.cache_dir) == 0 then
		os.execute("mkdir -p " .. global.cache_dir)
		for _, v in pairs(data_dir) do
			if vim.fn.isdirectory(v) == 0 then
				os.execute("mkdir -p " .. v)
			end
		end
	end
end

local init = function()
	createdir()
	
	require('r1v3r.pack')
	require('r1v3r.lang')
	require('r1v3r.options')
	require('r1v3r.keymaps')

	local colorscheme = require("r1v3r.settings").colorscheme
	local background = require("r1v3r.settings").background
    -- TODO enable when material ready
	-- vim.cmd("set background=" .. background)
	-- vim.cmd("colorscheme " .. colorscheme)
end

init()
