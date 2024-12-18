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

---@param s string
---@return mapOption
function mapOption:append(s)
	self.rhs = self.rhs .. s
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

---@param description string
---@return mapOption
function mapOption:desc(description)
	self.options.desc = description
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
function mapOption:vsc_call()
	self.rhs = ("call VSCodeCall('%s')"):format(self.rhs)
	return self:cmd()
end

-- set keymap
function mapOption:set()
	-- vim.keymap doc: https://neovim.io/doc/user/lua.html#vim.keymap
	vim.keymap.set(self.m ~= "" and vim.split(self.m, "") or "", self.lhs, self.rhs, self.options)
end

-- convert to lazy.nvim keys, format: LazyKeysSpec
function mapOption:to_lazy_key()
	local lazy_key = { self.lhs, self.rhs } -- 构造 LazyKeysSpec 表
	local mode = self.m ~= "" and (type(self.m) == "string" and vim.split(self.m, "") or self.m) or nil -- 处理 mode
	return vim.tbl_extend("force", lazy_key, mode and { mode = mode } or {}, self.options or {})
end

-- print keymap
function mapOption:print()
	if self.m ~= "" then
		vim.print(vim.inspect(vim.split(self.m, "")), self.lhs, self.rhs, vim.inspect(self.options))
	else
		vim.print("n", self.lhs, self.rhs, vim.inspect(self.options))
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
