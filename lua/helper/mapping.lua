---@class mapOption
---@field m string mode
---@field lhs string
---@field rhs string|function
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
function mapOption:space()
	self.rhs = (":%s<Space>"):format(self.rhs)
	return self
end

---@return mapOption
function mapOption:cmd()
	self.rhs = ("<Cmd>%s<CR>"):format(self.rhs)
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
	if type(self.rhs) == "string" then
		vim.cmd(tostring(self.rhs))
	else
		vim.notify("[keymap] exec rhs failed, rhs is not string.", vim.log.levels.ERROR, { title = "Exec failed" })
	end
end

---@return mapOption
function mapOption:vscCall()
	self.rhs = ("call VSCodeCall('%s')"):format(self.rhs)
	return self:cmd()
end

-- set keymap
function mapOption:set()
	-- vim.keymap doc: https://neovim.io/doc/user/lua.html#vim.keymap
	if self.m == "" then
		vim.keymap.set("", self.lhs, self.rhs, self.options)
	else
		vim.keymap.set(vim.split(self.m, ""), self.lhs, self.rhs, self.options)
	end
end

-- print keymap
function mapOption:print()
	if self.m ~= "" then
		print(vim.inspect(vim.split(self.m, "")), self.lhs, self.rhs, vim.inspect(self.options))
	else
		print("n", self.lhs, self.rhs, vim.inspect(self.options))
	end
end

---@param lhs string
---@param rhs string|function
---@return mapOption
function mapOption.map(lhs, rhs)
	local instance = {
		m = "",
		lhs = lhs,
		rhs = rhs,
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

---@param rhs_string string
---@return string escaped_string
function mapOption.escape_termcode(rhs_string)
	return vim.api.nvim_replace_termcodes(rhs_string, true, true, true)
end

return mapOption
