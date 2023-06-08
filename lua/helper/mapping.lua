---@class mapOption
---@field m string
---@field key string
---@field cmd string
---@field options table
---@field options.noremap boolean
---@field options.silent boolean
---@field options.expr boolean
---@field options.nowait boolean
---@field options.callback function
---@field options.desc string
---@field buf boolean|number
local mapOption = {}

---@return mapOption
function mapOption:new(key, cmd)
    local instance = {
        m = "",
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
        buf = false
    }
    setmetatable(instance, self)
    self.__index = self
    return instance
end

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

---@param callback fun():nil
--- Takes a callback that will be called when the key is pressed
---@return mapOption
function mapOption:callback(callback)
    self.cmd = ""
    self.options.callback = callback
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
    self.options.noremap = true
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
    vim.cmd(self.cmd)
end

function mapOption:set()
    local mode = self.m
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

function mapOption:print()
    local mode = self.m
    local lhs = self.key
    local rhs = self.cmd
    local options = self.options
    local buf = self.buf
    if buf and type(buf) == "number" then
        print(buf, mode, lhs, rhs, options)
    else
        print(mode, lhs, rhs, options)
    end
    for k, v in pairs(options) do
        print(k, v)
    end
end

local bind = {}

---@param key string
---@param cmd string
---@return mapOption
function bind.map(key, cmd)
    return mapOption:new(key, cmd)
end

---@param cmd_string string
---@return string escaped_string
function bind.escape_termcode(cmd_string)
    return vim.api.nvim_replace_termcodes(cmd_string, true, true, true)
end

return bind
