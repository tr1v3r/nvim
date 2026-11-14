-- Run with the full configuration: nvim --headless -i NONE "+luafile tests/wilder.lua" +qa
local function test()
	vim.cmd.edit("tests/fixtures/treesitter.md")
	require("lazy").load({ plugins = { "wilder.nvim" } })
	local wilder = require("wilder")
	local columns
	local border_theme = wilder.popupmenu_border_theme
	wilder.popupmenu_border_theme = function(opts)
		columns = opts.left
		return border_theme(opts)
	end
	local configured, config_error = pcall(require("tools.wilder"))
	wilder.popupmenu_border_theme = border_theme
	assert(configured, config_error)
	assert(columns and type(columns[2]) == "function" and type(columns[3]) == "function")

	local ctx = {
		session_id = 1,
		page = { 0, 0 },
		height = 1,
		highlights = { default = "Pmenu", selected = "PmenuSel" },
	}
	local shim = require("wilder.shim")
	local parsed = shim.call("wilder#cmdline#parse", "RenderMarkdown t")
	local prepared = shim.call("wilder#cmdline#prepare_user_completion", ctx, parsed)
	local expansion = prepared[3].expand
	assert(type(expansion) == "function", "Expected Lua custom completion callback")
	assert(vim.tbl_contains(vim.fn.getcompletion("RenderMarkdown t", "cmdline"), "toggle"))

	-- Both columns used to raise E704 for Lua custom-command completion metadata.
	for _, column in ipairs({ columns[2], columns[3] }) do
		assert(column(ctx, { value = { "toggle" }, data = { ["cmdline.expand"] = expansion } }) == "")
		assert(column(ctx, { value = { "toggle" }, data = { ["cmdline.expand"] = "command" } }) == "")
		assert(column(ctx, { value = { "toggle" } }) == "")
	end

	-- Normal file icons and buffer flags must remain visible.
	for _, kind in ipairs({ "file", "file_in_path", "buffer" }) do
		ctx.session_id = ctx.session_id + 1
		local result = {
			value = { "tests/fixtures/treesitter.md" },
			data = { ["cmdline.expand"] = kind },
		}
		for _, column in ipairs({ columns[2], columns[3] }) do
			local rows = column(ctx, result)
			assert(type(rows) == "table" and #rows == 1, kind .. " column did not render")
			local text = ""
			for _, chunk in ipairs(rows[1]) do
				text = text .. chunk[1]
			end
			assert(text:find("%S"), kind .. " icon or buffer flags disappeared")
		end
	end

	local renderer = require("render-markdown")
	assert(renderer.get(), "Markdown rendering should start enabled")
	vim.cmd("RenderMarkdown toggle")
	assert(not renderer.get(), "Markdown toggle did not disable rendering")
	vim.cmd("RenderMarkdown toggle")
	assert(renderer.get(), "Markdown toggle did not re-enable rendering")
	io.stdout:write("PASS: Lua command completion, file icons, buffer flags and Markdown toggle\n")
end

local ok, err = xpcall(test, debug.traceback)
if not ok then
	vim.api.nvim_err_writeln(err)
	vim.cmd.cquit(1)
end
