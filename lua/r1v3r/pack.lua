local fn, api = vim.fn, vim.api
local global = require("r1v3r.global")
local plugins_dir, data_dir = global.plugins_dir, global.data_dir
local lazy_path = data_dir .. "lazy/lazy.nvim"

local settings = require("r1v3r.settings")
local use_ssh = settings.use_ssh

local icons = {
	kind = require("r1v3r.icons").get("kind"),
	documents = require("r1v3r.icons").get("documents"),
	ui = require("r1v3r.icons").get("ui"),
	ui_sep = require("r1v3r.icons").get("ui", true),
	misc = require("r1v3r.icons").get("misc"),
}

local Lazy = {}

-- check: check if lazy.nvim exists, if not, download it
function Lazy.check()
	if vim.fn.isdirectory(lazy_path) ~= 1 then
		local lazy_repo = use_ssh and "git@github.com:folke/lazy.nvim.git" or "https://github.com/folke/lazy.nvim.git"
		api.nvim_command("!git clone --filter=blob:none --branch=stable " .. lazy_repo .. " " .. lazy_path)
	end
	vim.opt.rtp:prepend(lazy_path)
end

-- prepare: extend RTP
function Lazy.prepare()
	package.path = string.format("%s;%s;", plugins_dir .. "/configs/?.lua", plugins_dir .. "/configs/?/init.lua")
		.. package.path
end

-- plugins: get plugins table
function Lazy.plugins()
	local get_plugins = function()
		local list = {}
		local pluginsFiles = vim.split(fn.glob(plugins_dir .. "/*.lua"), "\n")
		if type(pluginsFiles) == "table" then
			for _, f in ipairs(pluginsFiles) do
				-- fill list with `plugins/*.lua`'s path used for later `require` like this:
				-- list[#list + 1] = "plugins/completion.lua"
				list[#list + 1] = f:sub(#plugins_dir - #"plugins" + 1, -1)
			end
		end
		return list
	end

	local pluginsSpec = {}

	local plugin_files = get_plugins()
	for _, p in ipairs(plugin_files) do
		-- require modules which returned in previous operation like this:
		-- local plugins = require("plugins/completion.lua")
		local plugins = require(p:sub(0, #p - #".lua"))
		if type(plugins) == "table" then
			for name, conf in pairs(plugins) do
				if not vim.g.vscode or conf["vsc"] then
					pluginsSpec[#pluginsSpec + 1] = vim.tbl_extend("force", { name }, conf)
				end
			end
		end
	end

	return pluginsSpec
end

-- opts: get lazy opts
function Lazy.opts()
	local opts = {
		root = data_dir .. "lazy", -- directory where plugins will be installed
		git = {
			log = { "-8" }, -- show the last 8 commits
			timeout = 300, -- kill processes that take more than 5 minutes
			url_format = use_ssh and "git@github.com:%s.git" or "https://github.com/%s.git",
		},
		install = {
			-- install missing plugins on startup. This doesn't increase startup time.
			missing = true,
			colorscheme = { settings.colorscheme },
		},
		ui = {
			-- a number<1 is a percentage., >1 is a fixed size
			size = { width = 0.88, height = 0.8 },
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
				list = {
					icons.ui_sep.BigCircle,
					icons.ui_sep.BigUnfilledCircle,
					icons.ui_sep.Square,
					icons.ui_sep.ChevronRight,
				},
			},
		},
		-- Output options for headless mode
		headless = {
			-- show the output from process commands like git
			process = true,
			-- show log messages
			log = true,
			-- show task start/end
			task = true,
			-- use ansi colors
			colors = true,
		},
		---@diagnostic disable-next-line: undefined-field
		concurrency = vim.uv.available_parallelism() * 2,
		performance = {
			cache = {
				enabled = true,
				path = vim.fn.stdpath("cache") .. "/lazy/cache",
				-- Once one of the following events triggers, caching will be disabled.
				-- To cache all modules, set this to `{}`, but that is not recommended.
				disable_events = { "UIEnter", "BufReadPre" },
				ttl = 3600 * 24 * 2, -- keep unused modules for up to 2 days
			},
			reset_packpath = true, -- reset the package path to improve startup time
			rtp = {
				reset = true, -- reset the runtime path to $VIMRUNTIME and the config directory
				---@type string[]
				paths = {}, -- add any custom paths here that you want to include in the rtp
			},
		},
	}

	return opts
end

-- README: https://github.com/folke/lazy.nvim
function Lazy:load_lazy()
	self:check()
	self:prepare()
	require("lazy").setup(self:plugins(), self:opts())
end

Lazy:load_lazy()
