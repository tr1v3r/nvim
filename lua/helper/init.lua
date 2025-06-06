local M = {}

---@class palette
---@field rosewater string
---@field flamingo string
---@field mauve string
---@field pink string
---@field red string
---@field maroon string
---@field peach string
---@field yellow string
---@field green string
---@field sapphire string
---@field blue string
---@field sky string
---@field teal string
---@field lavender string
---@field text string
---@field subtext1 string
---@field subtext0 string
---@field overlay2 string
---@field overlay1 string
---@field overlay0 string
---@field surface2 string
---@field surface1 string
---@field surface0 string
---@field base string
---@field mantle string
---@field crust string
---@field none "NONE"

---@type nil|palette
local palette = nil

-- Indicates if autocmd for refreshing the builtin palette has already been registered
---@type boolean
local _has_autocmd = false

---Initialize the palette
---@return palette
local function init_palette()
	-- Reinitialize the palette on event `ColorScheme`
	if not _has_autocmd then
		_has_autocmd = true
		vim.api.nvim_create_autocmd("ColorScheme", {
			group = vim.api.nvim_create_augroup("__builtin_palette", { clear = true }),
			pattern = "*",
			callback = function()
				palette = nil
				init_palette()
				-- Also refresh hard-coded hl groups
				M.gen_alpha_hl()
				M.gen_lspkind_hl()
				pcall(vim.cmd.AlphaRedraw)
			end,
		})
	end

	if not palette then
		palette = vim.g.colors_name:find("catppuccin") and require("catppuccin.palettes").get_palette()
			or {
				rosewater = "#DC8A78",
				flamingo = "#DD7878",
				mauve = "#CBA6F7",
				pink = "#F5C2E7",
				red = "#E95678",
				maroon = "#B33076",
				peach = "#FF8700",
				yellow = "#F7BB3B",
				green = "#AFD700",
				sapphire = "#36D0E0",
				blue = "#61AFEF",
				sky = "#04A5E5",
				teal = "#B5E8E0",
				lavender = "#7287FD",

				text = "#F2F2BF",
				subtext1 = "#BAC2DE",
				subtext0 = "#A6ADC8",
				overlay2 = "#C3BAC6",
				overlay1 = "#988BA2",
				overlay0 = "#6E6B6B",
				surface2 = "#6E6C7E",
				surface1 = "#575268",
				surface0 = "#302D41",

				base = "#1D1536",
				mantle = "#1C1C19",
				crust = "#161320",
			}

		palette = vim.tbl_extend("force", { none = "NONE" }, palette, require("r1v3r.settings").palette_overwrite)
	end

	return palette
end

---@param c string @The color in hexadecimal.
local function hex_to_rgb(c)
	c = string.lower(c)
	return { tonumber(c:sub(2, 3), 16), tonumber(c:sub(4, 5), 16), tonumber(c:sub(6, 7), 16) }
end

-- NOTE: If the active colorscheme isn't `catppuccin`, this function won't overwrite existing definitions
---Sets a global highlight group.
---@param name string @Highlight group name, e.g. "ErrorMsg"
---@param foreground string @The foreground color
---@param background? string @The background color
---@param italic? boolean
local function set_global_hl(name, foreground, background, italic)
	vim.api.nvim_set_hl(0, name, {
		fg = foreground,
		bg = background,
		italic = italic == true,
		default = not vim.g.colors_name:find("catppuccin"),
	})
end

---Blend foreground with background
---@param foreground string @The foreground color
---@param background string @The background color to blend with
---@param alpha number|string @Number between 0 and 1 for blending amount.
function M.blend(foreground, background, alpha)
	---@diagnostic disable-next-line: cast-local-type
	alpha = type(alpha) == "string" and (tonumber(alpha, 16) / 0xff) or alpha
	local bg = hex_to_rgb(background)
	local fg = hex_to_rgb(foreground)

	local blend_channel = function(i)
		local ret = (alpha * fg[i] + ((1 - alpha) * bg[i]))
		return math.floor(math.min(math.max(0, ret), 255) + 0.5)
	end

	return string.format("#%02x%02x%02x", blend_channel(1), blend_channel(2), blend_channel(3))
end

---Get RGB highlight by highlight group
---@param hl_group string @Highlight group name
---@param use_bg boolean @Returns background or not
---@param fallback_hl? string @Fallback value if the hl group is not defined
---@return string
function M.hl_to_rgb(hl_group, use_bg, fallback_hl)
	local hex = fallback_hl or "#000000"
	local hlexists = pcall(vim.api.nvim_get_hl, 0, { name = hl_group, link = false })

	if hlexists then
		local result = vim.api.nvim_get_hl(0, { name = hl_group, link = false })
		if use_bg then
			hex = result.bg and string.format("#%06x", result.bg) or "NONE"
		else
			hex = result.fg and string.format("#%06x", result.fg) or "NONE"
		end
	end

	return hex
end

--- Extend a highlight group
---@param name string @Target highlight group name
---@param def table @Attributes to be extended
function M.extend_hl(name, def)
	-- Validate inputs
	if type(name) ~= "string" then
		error("extend_hl: 'name' must be a string")
	end
	if type(def) ~= "table" then
		error("extend_hl: 'def' must be a table")
	end

	-- Try to get the current highlight definition
	local success, current_def = pcall(vim.api.nvim_get_hl, 0, { name = name, link = false })
	if not success or not current_def then
		vim.notify("Highlight group '" .. name .. "' does not exist", vim.log.levels.WARN)
		return
	end

	-- Merge attributes
	local combined_def = vim.tbl_deep_extend("force", current_def, def)

	-- Apply the new highlight definition
	---@diagnostic disable-next-line: param-type-mismatch
	vim.api.nvim_set_hl(0, name, combined_def)
end

---Generate universal highlight groups
---@param overwrite palette? @The color to be overwritten | highest priority
---@return palette
function M.get_palette(overwrite)
	if not overwrite then
		return vim.deepcopy(init_palette())
	else
		return vim.tbl_extend("force", init_palette(), overwrite)
	end
end

-- Generate highlight groups for lspsaga. Existing attributes will NOT be overwritten
function M.gen_lspkind_hl()
	local colors = M.get_palette()
	local dat = {
		Class = colors.yellow,
		Constant = colors.peach,
		Constructor = colors.sapphire,
		Enum = colors.yellow,
		EnumMember = colors.teal,
		Event = colors.yellow,
		Field = colors.teal,
		File = colors.rosewater,
		Function = colors.blue,
		Interface = colors.yellow,
		Key = colors.red,
		Method = colors.blue,
		Module = colors.blue,
		Namespace = colors.blue,
		Number = colors.peach,
		Operator = colors.sky,
		Package = colors.blue,
		Property = colors.teal,
		Struct = colors.yellow,
		TypeParameter = colors.blue,
		Variable = colors.peach,
		Array = colors.peach,
		Boolean = colors.peach,
		Null = colors.yellow,
		Object = colors.yellow,
		String = colors.green,
		TypeAlias = colors.green,
		Parameter = colors.blue,
		StaticMethod = colors.peach,
		Text = colors.green,
		Snippet = colors.mauve,
		Folder = colors.blue,
		Unit = colors.green,
		Value = colors.peach,
	}

	for kind, color in pairs(dat) do
		set_global_hl("LspKind" .. kind, color)
	end
end

-- Generate highlight groups for alpha. Existing attributes will NOT be overwritten
function M.gen_alpha_hl()
	local colors = M.get_palette()

	set_global_hl("AlphaHeader", colors.blue)
	set_global_hl("AlphaButtons", colors.green)
	set_global_hl("AlphaShortcut", colors.pink, nil, true)
	set_global_hl("AlphaFooter", colors.yellow)
end

-- neodim is disabled for now
-- -- Generate blend_color for neodim.
-- function M.gen_neodim_blend_attr()
-- 	local trans_bg = require("r1v3r.settings").transparent_background
-- 	local appearance = require("r1v3r.settings").background

-- 	if trans_bg and appearance == "dark" then
-- 		return "#000000"
-- 	elseif trans_bg and appearance == "light" then
-- 		return "#FFFFFF"
-- 	else
-- 		return M.hl_to_rgb("Normal", true)
-- 	end
-- end

---Convert number (0/1) to boolean
---@param value number @The value to check
---@return boolean|nil @Returns nil if failed
function M.tobool(value)
	if value == 0 then
		return false
	elseif value == 1 then
		return true
	else
		vim.notify(
			"Attempting to convert data of type '" .. type(value) .. "' [other than 0 or 1] to boolean",
			vim.log.levels.ERROR,
			{ title = "[utils] Runtime Error" }
		)
		return nil
	end
end

-- Create a new terminal in a floating window
-- @param cmd string @The command to run in the terminal
function M.float_terminal(cmd)
	-- ex:
	-- local cmd1 = "ls -l"
	-- local cmd2 = { flags = { "ls", "-l", "/home/user" } }
	if type(cmd) == "table" then
		cmd = table.concat(cmd.flags, " ")
	end

	-- 获取当前窗口的尺寸和位置
	-- get current nvim size, set floating window size and position
	local maxWidth = vim.o.columns -- vim.api.nvim_get_option_value("columns", {}) / vim.api.nvim_win_get_width(0)
	local maxHeight = vim.o.lines -- vim.api.nvim_get_option_value("lines", {}) / vim.api.nvim_win_get_height(0)
	local width = math.floor(maxWidth * 0.9)
	local height = math.floor(maxHeight * 0.9)
	local row = math.floor((maxHeight - height) / 2)
	local col = math.floor((maxWidth - width) / 2)
	local float_opts = {
		relative = "editor",
		width = width,
		height = height,
		row = row,
		col = col,
		style = "minimal",
		border = "none", -- none/single/double/rounded/solid/shadow/{ "x" }/{ "", "", "", ">", "", "", "", "<" }
		zindex = 50, -- 保证terminal在最上层 Ensure the terminal is at the top level.
	}

	-- 创建一个新的空白缓冲区
	-- create a new empty buffer
	local buf = vim.api.nvim_create_buf(false, true)
	vim.bo[buf].filetype = "terminal"

	-- docs: https://neovim.io/doc/user/api.html#nvim_open_win()
	local terminal_window = vim.api.nvim_open_win(buf, true, float_opts)
	vim.wo[terminal_window].number = false
	vim.wo[terminal_window].relativenumber = false
	vim.wo[terminal_window].winhighlight = "Normal:Normal" -- 设置浮动窗口的选项，避免影响底层窗口内容

	vim.fn.jobstart(cmd, {
		term = true,
		detach = 1,
		on_exit = function(_, code)
			-- 在退出终端时关闭浮动窗口
			-- close window when quit
			if code == 0 then
				vim.api.nvim_win_close(terminal_window, true)
			end
		end,
	})
	vim.cmd("startinsert")
end

return M
