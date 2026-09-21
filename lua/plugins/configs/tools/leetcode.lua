local settings = require("r1v3r.settings")

local domain = settings.leetcode_domain
assert(domain == "cn" or domain == "com", "leetcode_domain must be either 'cn' or 'com'")

local M = {}

local function setup_colemak_menu_keys()
	local MenuButton = require("leetcode-ui.lines.button.menu")
	if MenuButton._colemak_keys then
		return
	end

	local default_init = MenuButton.init
	local shortcuts = {
		i = "I",
		l = "L",
		u = "U",
	}

	function MenuButton:init(text, opts)
		opts = vim.deepcopy(opts)
		opts.sc = shortcuts[opts.sc] or opts.sc
		return default_init(self, text, opts)
	end

	MenuButton._colemak_keys = true
end

M.opts = {
	lang = settings.leetcode_lang,
	cn = {
		enabled = domain == "cn",
		translator = true,
		translate_problems = true,
	},
	picker = {
		provider = "snacks-picker",
	},
	plugins = {
		non_standalone = true,
	},
	keys = {
		toggle = { "q" },
		confirm = { "<CR>" },
		reset_testcases = "r",
		use_testcase = "T",
		focus_testcases = "N",
		focus_result = "I",
	},
}

function M.config(_, opts)
	require("leetcode").setup(opts)
	setup_colemak_menu_keys()

	if settings.leetcode_user_agent then
		package.loaded["leetcode.api.headers"] = {
			get = function()
				local config = require("leetcode.config")
				local cookie = require("leetcode.cache.cookie").get()
				return vim.tbl_extend("force", {
					["User-Agent"] = settings.leetcode_user_agent,
					["Referer"] = ("https://leetcode.%s"):format(config.domain),
					["Origin"] = ("https://leetcode.%s/"):format(config.domain),
					["Content-Type"] = "application/json",
					["Accept"] = "application/json",
					["Host"] = ("leetcode.%s"):format(config.domain),
				}, cookie and {
					["Cookie"] = cookie.str,
					["x-csrftoken"] = cookie.csrftoken,
				} or {})
			end,
		}
	end

	if opts.cn.enabled then
		require("leetcode.api.queries").auth = [[
			query globalData {
				userStatus {
					slug: userSlug
					name: username
					is_signed_in: isSignedIn
					is_premium: isPremium
					is_verified: isVerified
					session_id: activeSessionId
				}
			}
		]]
	end
end

return M
