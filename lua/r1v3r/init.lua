local global = require("r1v3r.global")

-- Create cache dir and data dirs
local createdir = function()
    local dataDir = {global.cacheDir .. "backup", global.cacheDir .. "undo", global.cacheDir .. "session",
                     global.cacheDir .. "swap", global.cacheDir .. "tags"}
    -- Only check whether cacheDir exists, this would be enough.
    if vim.fn.isdirectory(global.cacheDir) == 0 then
        os.execute("mkdir -p " .. global.cacheDir)
        for _, v in pairs(dataDir) do
            if vim.fn.isdirectory(v) == 0 then
                os.execute("mkdir -p " .. v)
            end
        end
    end
end

local init = function()
    createdir()

    require('r1v3r.lang')
    require('r1v3r.options')
    require('r1v3r.keymaps')
    require('r1v3r.event')
    require('r1v3r.pack')

    local colorscheme = require("r1v3r.settings").colorscheme
    local background = require("r1v3r.settings").background
    vim.api.nvim_command("set background=" .. background)
    vim.api.nvim_command("colorscheme " .. colorscheme)
end

init()
