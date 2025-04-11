local M = {}

M.opts = {
	---@alias Provider "claude" | "openai" | "azure" | "gemini" | "cohere" | "copilot" | "deepseek" | string
	provider = "deepseek", -- The provider used in Aider mode or in the planning phase of Cursor Planning Mode
	-- WARNING: Since auto-suggestions are a high-frequency operation and therefore expensive,
	-- currently designating it as `copilot` provider is dangerous because: https://github.com/yetone/avante.nvim/issues/1048
	-- Of course, you can reduce the request frequency by increasing `suggestion.debounce`.
	auto_suggestions_provider = "copilot",

	openai = { -- user env OPENAI_API_KEY
		endpoint = "https://api.openai.com/v1",
		model = "gpt-4o", -- your desired model (or use gpt-4o, etc.)
		timeout = 30000, -- Timeout in milliseconds, increase this for reasoning models
		temperature = 0,
		max_completion_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
		--reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
	},
	claude = { -- use env ANTHROPIC_API_KEY
		endpoint = "https://api.anthropic.com",
		model = "claude-3-5-sonnet-20241022",
		temperature = 0,
		max_tokens = 4096,
	},
	vendors = {
		deepseek = { -- use env DEEPSEEK_API_KEY
			__inherited_from = "openai",
			api_key_name = "DEEPSEEK_API_KEY",
			endpoint = "https://api.deepseek.com",
			model = "deepseek-coder", -- deepseek-chat -> DeepSeek-V3；deepseek-reasoner -> DeepSeek-R1
			timeout = 30000, -- Timeout in milliseconds, increase this for reasoning models
		},
	},
}

return M
