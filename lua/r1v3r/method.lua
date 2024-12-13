-- ================ Debug ================
local function GetAutocmdsForEvent(opts)
	local event_name = opts.args
	-- 使用 pcall 来安全地调用 API，并捕获可能的错误
	local status, autocmds = pcall(vim.api.nvim_get_autocmds, { event = event_name })
	if status then
		-- 如果调用成功，打印相关的自动命令
		vim.print(autocmds)
	else
		-- 如果发生错误，打印错误消息
		vim.print("Error retrieving autocmds for event: " .. event_name)
	end
end
vim.api.nvim_create_user_command(
	"GetAutocmdsForEvent",
	GetAutocmdsForEvent,
	{ nargs = 1, desc = "check autocmds for event" }
)

local function GetAutocmdsForGroup(opts)
	local group_name = opts.args
	local status, autocmds =
		pcall(vim.api.nvim_get_autocmds, { group = vim.api.nvim_create_augroup(group_name, { clear = false }) })
	if status then
		vim.print(autocmds)
	else
		vim.print("Error retrieving autocmds for group: " .. group_name)
	end
end
vim.api.nvim_create_user_command(
	"GetAutocmdsForGroup",
	GetAutocmdsForGroup,
	{ nargs = 1, desc = "check autocmds for group" }
)

local function ShowDapConfigurations(opts)
	local adapter = opts.args
	if adapter ~= "" then
		vim.print(require("dap").configurations[adapter])
	else
		vim.print(require("dap").configurations)
	end
end
vim.api.nvim_create_user_command(
	"ShowDapConfigurations",
	ShowDapConfigurations,
	{ nargs = 0, desc = "inspect dap configurations" }
)
