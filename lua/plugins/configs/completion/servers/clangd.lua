local function switch_source_header_splitcmd(bufnr, splitcmd)
	bufnr = vim.lsp.util.validate_bufnr(bufnr)
	-- local clangd_client = vim.lsp.util.get_active_client_by_name(bufnr, "clangd")
	local clangd_client
	for _, client in ipairs(vim.lsp.get_active_clients({ bufnr = bufnr })) do
		if client.name == "clangd" then
			clangd_client = client
			break
		end
	end

	local params = { uri = vim.uri_from_bufnr(bufnr) }
	if clangd_client then
		clangd_client.request("textDocument/switchSourceHeader", params, function(err, result)
			if err then
				error(tostring(err))
			end
			if not result then
				vim.notify("Corresponding file can’t be determined", vim.log.levels.ERROR, { title = "LSP Error!" })
				return
			end
			vim.api.nvim_command(splitcmd .. " " .. vim.uri_to_fname(result))
		end)
	else
		vim.notify(
			"Method textDocument/switchSourceHeader is not supported by any active server on this buffer",
			vim.log.levels.ERROR,
			{ title = "LSP Error!" }
		)
	end
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

-- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/server_configurations/clangd.lua
return function(options)
	-- capabilities 合并 offsetEncoding
	local capabilities = vim.tbl_deep_extend(
		"keep",
		{ offsetEncoding = { "utf-16", "utf-8" } },
		options.capabilities or vim.lsp.protocol.make_client_capabilities()
	)
	-- 定义 clangd 配置（等价于 lspconfig.setup 内的字段）
	local clangd_cfg = vim.lsp.config("clangd", {
		cmd = {
			"clangd",
			"-j=12",
			"--enable-config",
			"--background-index",
			"--pch-storage=memory",
			"--query-driver=" .. get_binary_path_list({ "clang++", "clang", "gcc", "g++" }),
			"--clang-tidy",
			"--all-scopes-completion",
			"--completion-style=detailed",
			"--header-insertion-decorators",
			"--header-insertion=iwyu",
			"--limit-references=3000",
			"--limit-results=270",
		},
		-- 典型 C/C++ 工程根标记；需要更精细可改 root_dir 函数
		root_markers = { "compile_commands.json", "compile_flags.txt", ".git" },
		on_attach = options.on_attach,
		capabilities = capabilities,
		single_file_support = true,
	})
	-- 启动方式改为在相关文件类型出现时调用 vim.lsp.start
	vim.api.nvim_create_autocmd("FileType", {
		group = vim.api.nvim_create_augroup("LspStartClangd", { clear = true }),
		pattern = { "c", "cpp", "objc", "objcpp" },
		callback = function()
			vim.lsp.start(clangd_cfg)
		end,
	})
	-- 将原来的 setup.commands 改为用户命令
	vim.api.nvim_create_user_command("ClangdSwitchSourceHeader", function()
		switch_source_header_splitcmd(0, "edit")
	end, { desc = "Open source/header in current buffer" })
	vim.api.nvim_create_user_command("ClangdSwitchSourceHeaderVSplit", function()
		switch_source_header_splitcmd(0, "vsplit")
	end, { desc = "Open source/header in a new vsplit" })
	vim.api.nvim_create_user_command("ClangdSwitchSourceHaderSplit", function()
		switch_source_header_splitcmd(0, "split")
	end, { desc = "Open source/header in a new split" })
end

-- deprecated version
-- require("lspconfig").clangd.setup({
-- 	on_attach = options.on_attach,
-- 	capabilities = vim.tbl_deep_extend("keep", { offsetEncoding = { "utf-16", "utf-8" } }, options.capabilities),
-- 	single_file_support = true,
-- 	cmd = {
-- 		"clangd",
-- 		"-j=12",
-- 		"--enable-config",
-- 		"--background-index",
-- 		"--pch-storage=memory",
-- 		-- You MUST set this arg ↓ to your c/cpp compiler location (if not included)!
-- 		"--query-driver=" .. get_binary_path_list({ "clang++", "clang", "gcc", "g++" }),
-- 		"--clang-tidy",
-- 		"--all-scopes-completion",
-- 		"--completion-style=detailed",
-- 		"--header-insertion-decorators",
-- 		"--header-insertion=iwyu",
-- 		"--limit-references=3000",
-- 		"--limit-results=270",
-- 	},
-- 	commands = {
-- 		ClangdSwitchSourceHeader = {
-- 			function()
-- 				switch_source_header_splitcmd(0, "edit")
-- 			end,
-- 			description = "Open source/header in current buffer",
-- 		},
-- 		ClangdSwitchSourceHeaderVSplit = {
-- 			function()
-- 				switch_source_header_splitcmd(0, "vsplit")
-- 			end,
-- 			description = "Open source/header in a new vsplit",
-- 		},
-- 		ClangdSwitchSourceHeaderSplit = {
-- 			function()
-- 				switch_source_header_splitcmd(0, "split")
-- 			end,
-- 			description = "Open source/header in a new split",
-- 		},
-- 	},
-- })
