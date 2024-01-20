---@class mapOption
---@field m string mode
---@field key string
---@field cmd string|function
---@field options table
---@field options.remap boolean
---@field options.nowait boolean
---@field options.silent boolean
---@field options.expr boolean
---@field options.script boolean
---@field options.unique boolean
---@field options.buffer integer|boolean
---@field options.desc string
local mapOption = {}

---@return mapOption
function mapOption:cr()
	self.cmd = (":%s<CR>"):format(self.cmd)
	return self
end

---@return mapOption
function mapOption:space()
	self.cmd = (":%s<Space>"):format(self.cmd)
	return self
end

---@return mapOption
function mapOption:Cmd()
	self.cmd = ("<Cmd>%s<CR>"):format(self.cmd)
	return self
end

---@return mapOption
function mapOption:pure()
	-- <C-u> to eliminate the automatically inserted range in visual mode
	self.cmd = (":<C-u>%s<CR>"):format(self.cmd)
	return self
end

---@param mode_string string
---@return mapOption
function mapOption:mode(mode_string)
	self.m = mode_string
	return self
end

---@return mapOption
function mapOption:silent()
	self.options.silent = true
	return self
end

---@param description string
---@return mapOption
function mapOption:desc(description)
	self.options.desc = description
	return self
end

---@return mapOption
function mapOption:noremap()
	self.options.remap = false
	return self
end

---@return mapOption
function mapOption:expr()
	self.options.expr = true
	return self
end

---@return mapOption
function mapOption:nowait()
	self.options.nowait = true
	return self
end

---@param num number
---@return mapOption
function mapOption:buffer(num)
	self.buf = num
	return self
end

function mapOption:exec()
	if type(self.cmd) == "string" then
		vim.cmd(tostring(self.cmd))
	else
		vim.notify("[Keymap] exec cmd failed, cmd is not string.", vim.log.levels.ERROR, { title = "Exec failed" })
	end
end

---@return mapOption
function mapOption:vscCall()
	self.cmd = ("<Cmd>call VSCodeCall('%s')<CR>"):format(self.cmd)
	return self
end

-- set keymap
function mapOption:set()
	-- vim.keymap doc: https://neovim.io/doc/user/lua.html#vim.keymap
	if self.m == "" then
		vim.keymap.set("", self.key, self.cmd, self.options)
	else
		vim.keymap.set(vim.split(self.m, ""), self.key, self.cmd, self.options)
	end
end

-- print keymap
function mapOption:print()
	if self.m ~= "" then
		print(vim.inspect(vim.split(self.m, "")), self.key, self.cmd, vim.inspect(self.options))
	else
		print("n", self.key, self.cmd, vim.inspect(self.options))
	end
end

---@param key string
---@param cmd string|function
---@return mapOption
function mapOption.map(key, cmd)
	local instance = {
		m = "",
		key = key,
		cmd = cmd,
		options = {
			remap = true,
			nowait = false,
			silent = false,
			expr = false,
			script = false,
			unique = false,
			buffer = false,
			desc = "",
		},
	}

	setmetatable(instance, { __index = mapOption })

	return instance
end

---@param cmd_string string
---@return string escaped_string
function mapOption.escape_termcode(cmd_string)
	return vim.api.nvim_replace_termcodes(cmd_string, true, true, true)
end

return mapOption
