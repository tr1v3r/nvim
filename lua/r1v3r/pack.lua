local fn, api = vim.fn, vim.api
local isMac = require("r1v3r.global").isMac
local pluginsDir = require("r1v3r.global").pluginsDir

local icons = {
    kind = require("r1v3r.icons").get("kind"),
    documents = require("r1v3r.icons").get("documents"),
    ui = require("r1v3r.icons").get("ui"),
    uiSep = require("r1v3r.icons").get("ui", true),
    misc = require("r1v3r.icons").get("misc")
}

local Lazy = {}

function Lazy:checkInstall()
    -- fn.stdpath("data") default value: ~/.local/share/nvim/
    local lazypath = fn.stdpath("data") .. "/lazy/lazy.nvim"
    if not vim.loop.fs_stat(lazypath) then
        -- bootstrap lazy.nvim
        -- stylua: ignore
        local output = fn.system({"git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git",
                                  "--branch=stable", lazypath})
        if vim.api.nvim_get_vvar("shell_error") ~= 0 then
            vim.api.nvim_err_writeln("Error cloning lazy.nvim repository...\n\n" .. output)
        end
    end
    vim.opt.rtp:prepend(vim.env.LAZY or lazypath)
end

function Lazy:extendRTP()
    plugConfDir = pluginsDir .. "/configs/"
    package.path = string.format("%s;%s;", plugConfDir .. "?.lua", plugConfDir .. "?/init.lua") .. package.path
end

function Lazy:loadPlugins()
    local getPlugins = function()
        local list = {}
        local pluginsFiles = vim.split(fn.glob(pluginsDir .. "/*.lua"), "\n")
        if type(pluginsFiles) == "table" then
            for _, f in ipairs(pluginsFiles) do
                -- fill list with `plugins/*.lua`'s path used for later `require` like this:
                -- list[#list + 1] = "plugins/completion.lua"
                list[#list + 1] = f:sub(#pluginsDir - #"plugins" + 1, -1)
            end
        end
        return list
    end

    local pluginsSpec = {}

    local pluginsFiles = getPlugins()
    for _, p in ipairs(pluginsFiles) do
        -- require modules which returned in previous operation like this:
        -- local plugins = require("plugins/completion.lua")
        local plugins = require(p:sub(0, #p - #".lua"))
        if type(plugins) == "table" then
            for name, conf in pairs(plugins) do
                if not vim.g.vscode or conf["vsc"] then
                    pluginsSpec[#pluginsSpec + 1] = vim.tbl_extend("force", {name}, conf)
                end
            end
        end
    end

    return pluginsSpec
end

function Lazy:opts()
    local opts = {
        ui = {
            -- a number<1 is a percentage., >1 is a fixed size
            size = {
                width = 0.88,
                height = 0.8
            },
            wrap = true, -- wrap the lines in the ui
            -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
            border = "rounded",
            icons = {
                cmd = icons.misc.Code,
                config = icons.ui.Gear,
                event = icons.kind.Event,
                ft = icons.documents.Files,
                init = icons.misc.ManUp,
                import = icons.documents.Import,
                keys = icons.ui.Keyboard,
                loaded = icons.ui.Check,
                not_loaded = icons.misc.Ghost,
                plugin = icons.ui.Package,
                runtime = icons.misc.Vim,
                source = icons.kind.StaticMethod,
                start = icons.ui.Play,
                list = {icons.uiSep.BigCircle, icons.uiSep.BigUnfilledCircle, icons.uiSep.Square,
                        icons.uiSep.ChevronRight}
            }
        },
        performance = {
            cache = {
                enabled = true
            },
            path = fn.stdpath("cache") .. "/lazy/cache",
            -- Once one of the following events triggers, caching will be disabled.
            -- To cache all modules, set this to `{}`, but that is not recommended.
            disable_events = {"UIEnter", "BufReadPre"},
            ttl = 3600 * 24 * 2 -- keep unused modules for up to 2 days
        }
    }

    if isMac then
        opts.concurrency = 20
    end

    return opts
end

-- README: https://github.com/folke/lazy.nvim
function Lazy:init()
    self:checkInstall()
    self:extendRTP()
    require('lazy').setup(self:loadPlugins(), self:opts())
end

Lazy:init()
