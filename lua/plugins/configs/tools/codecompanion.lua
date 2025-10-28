local M = {}

M.opts = {
	-- AI provider configuration
	providers = {
		openai = {
			api_key = os.getenv("DEEPSEEK_API_KEY"),
			model = "deepseek-reasoner",
			base_url = "https://api.deepseek.com",
			max_tokens = 4096,
			temperature = 0.1,
			-- Available DeepSeek models:
			-- "deepseek-chat" - General purpose chat (recommended)
			-- "deepseek-reasoner" - Enhanced reasoning capabilities
		},
		-- Alternative providers you can enable:
		-- anthropic = {
		--   api_key = os.getenv("ANTHROPIC_API_KEY"),
		--   model = "claude-3-5-sonnet-20241022",
		--   max_tokens = 4096,
		-- },
		-- ollama = {
		--   model = "codellama:7b",
		--   base_url = "http://localhost:11434",
		-- },
	},

	-- Strategy configuration
	strategies = {
		chat = {
			provider = "openai",
			-- Optional: override provider settings for this strategy
			-- model = "deepseek-reasoner",
		},
		inline = {
			provider = "openai",
			-- Inline completion settings
			max_tokens = 256,
			-- Optional: use reasoning model for better suggestions
			-- model = "deepseek-reasoner",
		},
		assist = {
			provider = "openai",
			-- Code assistance settings
			-- model = "deepseek-reasoner",
		},
	},

	-- UI configuration
	ui = {
		border = "rounded",
		width = 0.8,
		height = 0.8,
		-- Optional: customize the appearance
		-- winblend = 10,
		-- title = "Code Companion",
	},

	-- Keymaps configuration
	keymaps = {
		-- These will be set up in your keymaps configuration
	},

	-- Additional features
	features = {
		-- Enable inline code suggestions
		inline_suggestions = true,
		-- Enable chat functionality
		chat = true,
		-- Enable code assistance
		code_assist = true,
	},

	-- Context configuration
	context = {
		-- Include current file context
		current_file = true,
		-- Include project context
		project = true,
		-- Maximum context length
		max_length = 4000,
	},
}

-- Optional: Custom setup function if you need more complex configuration
M.setup = function()
	require("codecompanion").setup(M.opts)
end

return M
