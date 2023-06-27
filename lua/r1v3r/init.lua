-- Run :set rtp? to list all nvim config dirs will be searched when neovim start
local global = require("r1v3r.global")

-- createDir cache dir and data dirs
local createDir = function()
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

-- deviceConfig load device config
local deviceConfig = function()
    local deviceConfig = os.getenv("HOME") .. "/.config/nvim/_device.lua"
    if vim.fn.empty(vim.fn.glob(deviceConfig)) == 1 then
        print("device lua not found")
    else
        dofile(deviceConfig)
    end
end

local init = function()
    createDir()

    require('r1v3r.lang')
    require('r1v3r.options')
    require('r1v3r.keymaps')
    require('r1v3r.event')
    require('r1v3r.pack')

    local colorscheme = require("r1v3r.settings").colorscheme
    local background = require("r1v3r.settings").background
    vim.api.nvim_command("set background=" .. background)
    vim.cmd.colorscheme(colorscheme)

    deviceConfig()
end

init()
