-- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/server_configurations/clangd.lua
local function switch_source_header_splitcmd(bufnr, splitcmd)
	bufnr = vim.lsp.util.validate_bufnr(bufnr)
	local uri = vim.uri_from_bufnr(bufnr)
	local clangd_client = vim.lsp.get_clients({ bufnr = bufnr, name = "clangd" })[1]
	if not clangd_client then
		vim.notify(
			"Method textDocument/switchSourceHeader is not supported by any active server on the buffer",
			vim.log.levels.ERROR,
			{ title = "LSP Error!" }
		)
		return
	end

	clangd_client:request("textDocument/switchSourceHeader", uri, function(err, result)
		if err then
			error(tostring(err))
		end
		if not result then
			vim.notify("Corresponding file can’t be determined", vim.log.levels.ERROR, { title = "LSP Error!" })
			return
		end
		vim.api.nvim_command(splitcmd .. " " .. vim.uri_to_fname(result))
	end)
end

local function get_binary_path_list(binaries)
	local path_list = {}
	for _, binary in ipairs(binaries) do
		local path = vim.fn.exepath(binary)
		if path ~= "" then
			table.insert(path_list, path)
		end
	end
	return table.concat(path_list, ",")
end

-- Expose the source/header switch as user commands (bound in `event.lua`).
vim.api.nvim_create_user_command("ClangdSwitchSourceHeader", function()
	switch_source_header_splitcmd(0, "edit")
end, { desc = "Open source/header in current buffer" })
vim.api.nvim_create_user_command("ClangdSwitchSourceHeaderVSplit", function()
	switch_source_header_splitcmd(0, "vsplit")
end, { desc = "Open source/header in a new vsplit" })
vim.api.nvim_create_user_command("ClangdSwitchSourceHeaderSplit", function()
	switch_source_header_splitcmd(0, "split")
end, { desc = "Open source/header in a new split" })

return {
	cmd = {
		"clangd",
		"-j=12",
		"--enable-config",
		"--background-index",
		"--pch-storage=memory",
		-- You MUST set this arg ↓ to your c/cpp compiler location (if not included)!
		"--query-driver=" .. get_binary_path_list({ "clang++", "clang", "gcc", "g++" }),
		"--clang-tidy",
		"--all-scopes-completion",
		"--completion-style=detailed",
		"--header-insertion-decorators",
		"--header-insertion=iwyu",
		"--limit-references=3000",
		"--limit-results=270",
	},
	filetypes = { "c", "cpp", "objc", "objcpp" },
	root_markers = { "compile_commands.json", "compile_flags.txt", ".git" },
	-- Merged with the "*" capabilities: keep utf-16 first for nvim offsets.
	capabilities = { offsetEncoding = { "utf-16", "utf-8" } },
}
