-- Run with the full configuration: nvim --headless -i NONE "+luafile tests/lsp-typescript.lua" +qa
local function test()
	assert(vim.fn.executable("typescript-language-server") == 1, "typescript-language-server is not on PATH")
	local project = vim.fn.tempname()
	vim.fn.mkdir(project, "p")
	vim.fn.writefile(
		{ '{"compilerOptions":{"allowJs":true,"jsx":"preserve"},"include":["*"]}' },
		project .. "/tsconfig.json"
	)
	vim.fn.writefile(
		{ 'export function greet(name: string) { return "Hello " + name; }' },
		project .. "/definitions.ts"
	)

	for extension, filetype in pairs({
		ts = "typescript",
		tsx = "typescriptreact",
		js = "javascript",
		jsx = "javascriptreact",
	}) do
		local source = project .. "/main." .. extension
		vim.fn.writefile({ 'import { greet } from "./definitions";', 'greet("test");' }, source)
		vim.cmd.edit(vim.fn.fnameescape(source))
		local bufnr = vim.api.nvim_get_current_buf()
		assert(vim.bo[bufnr].filetype == filetype, "Wrong filetype for " .. extension)
		assert(
			vim.wait(15000, function()
				local clients = vim.lsp.get_clients({ bufnr = bufnr, name = "ts_ls" })
				return #clients == 1 and clients[1].initialized
			end, 20),
			"ts_ls did not attach to " .. extension
		)
		local client = vim.lsp.get_clients({ bufnr = bufnr, name = "ts_ls" })[1]
		assert(vim.uv.fs_realpath(client.config.root_dir) == vim.uv.fs_realpath(project), "Wrong project root")
		assert(client:supports_method("textDocument/completion", bufnr), "Completion unavailable")
		assert(client:supports_method("textDocument/codeAction", bufnr), "Code actions unavailable")
		vim.api.nvim_win_set_cursor(0, { 2, 0 })
		local params = vim.lsp.util.make_position_params(0, client.offset_encoding)

		local function request(method, request_params)
			local response, err = client:request_sync(method, request_params, 10000, bufnr)
			assert(response, err or (method .. " timed out"))
			assert(not response.err, vim.inspect(response.err))
			assert(response.result, method .. " returned no result")
			return response.result
		end

		local definitions = request("textDocument/definition", params)
		assert(#definitions > 0, "No definition for " .. extension)
		local target = definitions[1].uri or definitions[1].targetUri
		assert(
			vim.uv.fs_realpath(vim.uri_to_fname(target)) == vim.uv.fs_realpath(project .. "/definitions.ts"),
			"Unexpected definition for " .. extension .. ": " .. vim.inspect(definitions)
		)
		local hover = request("textDocument/hover", params)
		assert(hover.contents, "Hover returned no contents")
		local references = request(
			"textDocument/references",
			vim.tbl_extend("force", params, {
				context = { includeDeclaration = true },
			})
		)
		assert(#references >= 2, "References did not include the definition and use")
		local rename = request("textDocument/rename", vim.tbl_extend("force", params, { newName = "welcome" }))
		assert(rename.changes or rename.documentChanges, "Rename returned no edits")

		local jump = vim.fn.maparg("ge", "n", false, true)
		assert(type(jump.callback) == "function", "ge jump keymap was not installed")
		assert(vim.fn.maparg("gd", "n"):match("Glance definitions"), "gd preview keymap was not installed")
		jump.callback()
		assert(
			vim.wait(5000, function()
				return vim.uv.fs_realpath(vim.api.nvim_buf_get_name(0))
					== vim.uv.fs_realpath(project .. "/definitions.ts")
			end, 20),
			"ge did not jump to the definition for " .. extension
		)
		print(extension .. ": attach, definition, hover, references, rename, completion capabilities, ge/gd OK")
	end

	local standalone = vim.fn.tempname() .. ".ts"
	vim.fn.writefile({ "function local_symbol() {}", "local_symbol();" }, standalone)
	vim.cmd.edit(vim.fn.fnameescape(standalone))
	local bufnr = vim.api.nvim_get_current_buf()
	assert(
		vim.wait(15000, function()
			local clients = vim.lsp.get_clients({ bufnr = bufnr, name = "ts_ls" })
			return #clients == 1 and clients[1].initialized
		end, 20),
		"ts_ls did not attach to a standalone file"
	)
	vim.api.nvim_win_set_cursor(0, { 2, 0 })
	vim.fn.maparg("ge", "n", false, true).callback()
	assert(
		vim.wait(5000, function()
			return vim.api.nvim_win_get_cursor(0)[1] == 1
		end, 20),
		"Standalone definition jump failed"
	)
	print("standalone TS: attach and ge OK")
end

local ok, err = xpcall(test, debug.traceback)
if not ok then
	vim.api.nvim_err_writeln(err)
	vim.cmd.cquit(1)
end
