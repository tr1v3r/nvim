---@class mapOption
---@field mode string
---@field key string
---@field cmd string
---@field options table
---@field options.noremap boolean
---@field options.silent boolean
---@field options.expr boolean
---@field options.nowait boolean
---@field options.callback function
---@field options.desc string
---@field buffer boolean|number
local option = {}

---@return mapOption
function option:new(key, cmd)
    local instance = {
        mode = "",
        key = key,
        cmd = cmd,
        options = {
            noremap = false,
            silent = false,
            expr = false,
            nowait = false,
            callback = nil,
            desc = ""
        },
        buffer = false
    }
    setmetatable(instance, self)
    self.__index = self
    return instance
end

---@return mapOption
function option:cr()
    self.cmd = (":%s<CR>"):format(self.cmd)
    return self
end

---@return mapOption
function option:space()
    self.cmd = (":%s<Space>"):format(self.cmd)
    return self
end

---@return mapOption
function option:pure()
    -- <C-u> to eliminate the automatically inserted range in visual mode
    self.cmd = (":<C-u>%s<CR>"):format(cmd_string)
    return self
end

---@param mode string
---@return mapOption
function option:mode(mode)
    self.mode = mode
    return self
end

---@param callback fun():nil
--- Takes a callback that will be called when the key is pressed
---@return mapOption
function option:callback(callback)
    self.cmd = ""
    self.options.callback = callback
    return self
end

---@return mapOption
function option:with_silent()
    self.options.silent = true
    return self
end

---@param description string
---@return mapOption
function option:with_desc(description)
    self.options.desc = description
    return self
end

---@return mapOption
function option:with_noremap()
    self.options.noremap = true
    return self
end

---@return mapOption
function option:expr()
    self.options.expr = true
    return self
end

---@return mapOption
function option:nowait()
    self.options.nowait = true
    return self
end

---@param num number
---@return mapOption
function option:buffer(num)
    self.buffer = num
    return self
end

function option:set()
    local mode = self.mode
    local lhs = self.key
    local rhs = self.cmd
    local options = self.options
    local buf = self.buffer
    if buf and type(buf) == "number" then
        vim.api.nvim_buf_set_keymap(buf, mode, lhs, rhs, options)
    else
        vim.api.nvim_set_keymap(mode, lhs, rhs, options)
    end
end

function option:print()
    local mode = self.mode
    local lhs = self.key
    local rhs = self.cmd
    local options = self.options
    local buf = self.buffer
    if buf and type(buf) == "number" then
        print(buf, mode, lhs, rhs, options)
    else
        print(mode, lhs, rhs, options)
    end
end

local bind = {}

---@param key string
---@param cmd string
---@return mapOption
function bind.map(key, cmd)
    return option:new(key, cmd)
end

---@param cmd_string string
---@return string escaped_string
function bind.escape_termcode(cmd_string)
    return vim.api.nvim_replace_termcodes(cmd_string, true, true, true)
end

return bind
