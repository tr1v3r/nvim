-- Run with the full configuration: nvim --headless -i NONE "+luafile tests/telescope-symbols.lua" +qa
local function test()
	assert(vim.fn.executable("gopls") == 1, "gopls is not on PATH")
	-- Exercise Neovim's LSP client without vim-go starting a second gopls client.
	vim.g.go_gopls_enabled = 0
	local project = vim.fn.tempname()
	vim.fn.mkdir(project, "p")
	vim.fn.writefile({ "module example.com/symbols", "", "go 1.26" }, project .. "/go.mod")

	for _, path in ipairs({ "ordinary/main.go", "cache/cache.go", "cache/benchmark_test.go" }) do
		local source = project .. "/" .. path
		vim.fn.mkdir(vim.fn.fnamemodify(source, ":h"), "p")
		vim.fn.writefile({ "package symbols", "", "func Symbol() {}" }, source)
		vim.cmd.edit(vim.fn.fnameescape(source))
		local bufnr = vim.api.nvim_get_current_buf()
		assert(
			vim.wait(15000, function()
				local clients = vim.lsp.get_clients({ bufnr = bufnr, name = "gopls" })
				return #clients == 1 and clients[1].initialized
			end, 20),
			"gopls did not attach to " .. path
		)
		assert(
			vim.wait(10000, function()
				local data = package.loaded["aerial.data"]
				return data and data.has_symbols(bufnr)
			end, 20),
			"Aerial did not receive symbols for " .. path
		)
		local symbols = require("aerial.data").get_or_create(bufnr).flat_items
		assert(#symbols > 0, "No source symbols for " .. path)

		local keymap = vim.fn.maparg("go", "n", false, true)
		assert(type(keymap.callback) == "function", "go keymap was not installed")
		keymap.callback()
		local picker = require("telescope.actions.state").get_current_picker(vim.api.nvim_get_current_buf())
		assert(picker.prompt_title == "Document Symbols", "go opened the wrong picker")
		assert(
			vim.wait(3000, function()
				return picker.manager and picker.manager:num_results() == #symbols
			end, 20),
			"Telescope filtered out document symbols for " .. path
		)
		assert(picker:get_selection().name == "Symbol", "Wrong symbol selected for " .. path)
		require("telescope.actions").close(picker.prompt_bufnr)
		print(path .. ": gopls, Aerial and go picker OK")
	end

	local patterns = require("telescope.config").values.file_ignore_patterns
	local function ignored(path)
		for _, pattern in ipairs(patterns) do
			if path:find(pattern) then
				return true
			end
		end
		return false
	end
	assert(ignored(".cache/generated.go"), "Relative .cache directory is no longer ignored")
	assert(ignored(project .. "/.cache/generated.go"), "Nested .cache directory is no longer ignored")
	assert(not ignored(project .. "/cache/cache.go"), "Ordinary cache package is ignored")
	assert(not ignored(project .. "/cache.go"), "Ordinary cache.go file is ignored")
	print("Hidden .cache directories remain ignored; ordinary cache paths stay visible")
end

local ok, err = xpcall(test, debug.traceback)
if not ok then
	vim.api.nvim_err_writeln(err)
	vim.cmd.cquit(1)
end
