local M = {}

M.opts = {
	mappings = {
		submit = {
			normal = "<CR>",
			insert = "<C-o>",
		},
		sidebar = {
			apply_all = "A",
			apply_cursor = "a",
			retry_user_request = "r",
			edit_user_request = "i",
			switch_windows = "<Tab>",
			reverse_switch_windows = "<S-Tab>",
			remove_file = "d",
			add_file = "@",
			close = { "<Esc>", "q" },
			close_from_input = nil, -- e.g., { normal = "<Esc>", insert = "<C-d>" }
		},
	},

	---@alias Provider "claude" | "openai" | "azure" | "gemini" | "cohere" | "copilot" | "deepseek" | string
	provider = "claude-code", -- The provider used in Aider mode or in the planning phase of Cursor Planning Mode
	-- WARNING: Since auto-suggestions are a high-frequency operation and therefore expensive,
	-- currently designating it as `copilot` provider is dangerous because: https://github.com/yetone/avante.nvim/issues/1048
	-- Of course, you can reduce the request frequency by increasing `suggestion.debounce`.
	auto_suggestions_provider = "copilot",

	-- Performance optimizations
	suggestion = {
		debounce = 500, -- Increase debounce time to reduce API calls
	},

	acp_providers = {
		["claude-code"] = {
			command = "npx",
			args = { "@zed-industries/claude-code-acp" },
			env = {
				NODE_NO_WARNINGS = "1",
				ANTHROPIC_BASE_URL = "https://api.deepseek.com/anthropic",
				API_TIMEOUT_MS = 600000,
				ANTHROPIC_MODEL = "deepseek-reasoner",
				ANTHROPIC_SMALL_FAST_MODEL = "deepseek-reasoner",
				CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC = 1,
				ANTHROPIC_API_KEY = os.getenv("ANTHROPIC_AUTH_TOKEN"),
			},
		},
	},

	providers = {
		-- Only keep providers you actually use to reduce configuration complexity
		deepseek = { -- use env DEEPSEEK_API_KEY
			__inherited_from = "openai",
			api_key_name = "DEEPSEEK_API_KEY",
			endpoint = "https://api.deepseek.com",
			model = "deepseek-reasoner", -- deepseek-chat -> DeepSeek-V3.2；deepseek-reasoner -> DeepSeek-V3.2
			timeout = 60000, -- Increased timeout for reasoning models
			extra_request_body = {
				temperature = 0,
				max_completion_tokens = 16384, -- Increased for reasoning models
			},
		},
		-- Optional: Uncomment if you need these providers
		-- openai = { -- user env OPENAI_API_KEY
		-- 	endpoint = "https://api.openai.com/v1",
		-- 	model = "gpt-4o",
		-- 	timeout = 30000,
		-- 	extra_request_body = {
		-- 		temperature = 0,
		-- 		max_completion_tokens = 8192,
		-- 	},
		-- },
		-- claude = { -- use env ANTHROPIC_API_KEY
		-- 	endpoint = "https://api.anthropic.com",
		-- 	model = "claude-3-5-sonnet-20241022",
		-- 	extra_request_body = {
		-- 		temperature = 0,
		-- 		max_tokens = 4096,
		-- 	},
		-- },
	},
}

return M
