local M = {}

M.deepseek_opts = {
	api_host_cmd = "echo https://api.deepseek.com",
	api_key_cmd = "echo $DEEPSEEK_API_KEY",
	api_type_cmd = "echo deepseek",

	openai_params = {
		model = "deepseek-coder",
		frequency_penalty = 0,
		presence_penalty = 0,
		max_tokens = 4095,
		temperature = 0.2,
		top_p = 0.1,
		n = 1,
	},
}

-- this config assumes you have OPENAI_API_KEY environment variable set
M.chatgpt_opts = {
	-- NOTE: model can be a function returning the model name
	-- this is useful if you want to change the model on the fly
	-- using commands
	-- Example:
	-- model = function()
	--     if some_condition() then
	--         return "gpt-4-1106-preview"
	--     else
	--         return "gpt-3.5-turbo"
	--     end
	-- end,
	model = "gpt-4-1106-preview",
	frequency_penalty = 0,
	presence_penalty = 0,
	max_tokens = 4095,
	temperature = 0.2,
	top_p = 0.1,
	n = 1,
}

setmetatable(M, {
	__call = function(self)
		-- Hook os.getenv to return empty string for OPENAI_API_KEY, forcing the ChatGPT plugin to use Deepseek configuration instead
		local original_getenv = os.getenv
		os.getenv = function(var)
			if var == "OPENAI_API_KEY" then
				return ""
			end
			return original_getenv(var)
		end

		require("chatgpt").setup(M.deepseek_opts)

		os.getenv = original_getenv
	end,
})

return M
