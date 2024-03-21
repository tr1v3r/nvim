local M = {}

local settings = require("r1v3r.settings")

local disabled_workspaces = settings.format_disabled_dirs

local format_on_save = settings.format_on_save
local format_notify = settings.format_notify
local format_modifications_only = settings.format_modifications_only

local block_formatters = settings.format_block_formatters
local block_filetypes = settings.format_block_filetypes

vim.api.nvim_create_user_command("FormatOnSaveToggle", function()
	M.toggle_format_on_save()
end, {})
vim.api.nvim_create_user_command("FormatToggleForFt", function(opts)
	M.toggle_format_for_ft(opts)
end, { nargs = 1, complete = "filetype" })

function M.enable_format_on_save(from_config)
	local opts = { pattern = "*", timeout = 1000 }
	vim.api.nvim_create_augroup("format_on_save", { clear = true })
	vim.api.nvim_create_autocmd("BufWritePre", {
		group = "format_on_save",
		pattern = opts.pattern,
		callback = function()
			require("completion.formatting").format({
				timeout_ms = opts.timeout,
				filter = M.formatter_filter,
			})
		end,
	})
	if not from_config then
		vim.notify(
			"Successfully enabled format-on-save",
			vim.log.levels.INFO,
			{ title = "Settings modification success" }
		)
	end
end

function M.disable_format_on_save(is_configured)
	pcall(vim.api.nvim_del_augroup_by_name, "format_on_save")
	if not is_configured then
		vim.notify(
			"Successfully disabled format-on-save",
			vim.log.levels.INFO,
			{ title = "Settings modification success" }
		)
	end
end

function M.configure_format_on_save()
	if format_on_save then
		M.enable_format_on_save(true)
	else
		M.disable_format_on_save(true)
	end
end

function M.toggle_format_on_save()
	local status = pcall(vim.api.nvim_get_autocmds, {
		group = "format_on_save",
		event = "BufWritePre",
	})
	if not status then
		M.enable_format_on_save(false)
	else
		M.disable_format_on_save(false)
	end
end

function M.toggle_format_for_ft(opts)
	if block_filetypes[opts.args] == nil then
		block_filetypes[opts.args] = true
		vim.notify(
			string.format("[LSP] Format for [%s] has been recorded in list and disabled.", opts.args),
			vim.log.levels.WARN,
			{ title = "LSP Formatter Warning" }
		)
	else
		block_filetypes[opts.args] = not block_filetypes[opts.args]
		vim.notify(
			string.format(
				"[LSP] Format for [%s] has been %s.",
				opts.args,
				not block_filetypes[opts.args] and "enabled" or "disabled"
			),
			not block_filetypes[opts.args] and vim.log.levels.INFO or vim.log.levels.WARN,
			{ title = string.format("LSP Format %s", not block_filetypes[opts.args] and "Info" or "Warning") }
		)
	end
end

function M.formatter_filter(formatters)
	return vim.tbl_filter(function(formatter)
		if block_formatters[formatter.name] then
			return false
		end

		local status_ok, formatting_supported = pcall(function()
			return formatter.supports_method("textDocument/formatting")
		end)
		return status_ok and formatting_supported
	end, formatters)
end

function M.format(opts)
	-- check workspaces
	local filedir = vim.fn.expand("%:p:h")
	for i = 1, #disabled_workspaces do
		if vim.regex(vim.fs.normalize(disabled_workspaces[i])):match_str(filedir) ~= nil then
			vim.notify(
				string.format(
					"[LSP] Formatting for all files under [%s] has been disabled.",
					vim.fs.normalize(disabled_workspaces[i])
				),
				vim.log.levels.WARN,
				{ title = "LSP Formatter Warning" }
			)
			return
		end
	end

	-- check filetypes
	if block_filetypes[vim.bo.filetype] then
		vim.notify(
			string.format(
				"[LSP] Formatting for [%s] files has been disabled. This file is not going to be formatted.",
				vim.bo.filetype
			),
			vim.log.levels.WARN,
			{ title = "LSP Formatter Warning" }
		)
		return
	end

	-- get formatters
	local bufnr = opts.bufnr or vim.api.nvim_get_current_buf()
	local formatters = vim.lsp.buf_get_clients(bufnr)

	if opts.filter then
		formatters = opts.filter(formatters)
	elseif opts.id then
		formatters = vim.tbl_filter(function(client)
			return client.id == opts.id
		end, formatters)
	elseif opts.name then
		formatters = vim.tbl_filter(function(client)
			return client.name == opts.name
		end, formatters)
	end

	formatters = vim.tbl_filter(function(formatter)
		return formatter.supports_method("textDocument/formatting")
	end, formatters)

	if #formatters == 0 then
		vim.notify(
			"[LSP] Format request failed, no matching language servers found.",
			vim.log.levels.WARN,
			{ title = "Formatting Failed" }
		)
		return
	end

	local timeout_ms = opts.timeout_ms
	for _, formatter in pairs(formatters) do
		if format_modifications_only then
			local success = require("lsp-format-modifications").format_modifications(formatter, bufnr).success
			if success and format_notify then
				vim.notify(
					string.format("[LSP] Format changed lines successfully with %s!", formatter.name),
					vim.log.levels.INFO,
					{ title = "LSP Range Format Success" }
				)
				return
			end
		end

		local params = vim.lsp.util.make_formatting_params(opts.formatting_options)
		local result, err = formatter.request_sync("textDocument/formatting", params, timeout_ms, bufnr)
		if result and result.result then
			vim.lsp.util.apply_text_edits(result.result, bufnr, formatter.offset_encoding)
			if format_notify then
				vim.notify(
					string.format("[LSP] Format successfully with %s!", formatter.name),
					vim.log.levels.INFO,
					{ title = "LSP Format Success" }
				)
			end
		elseif err then
			vim.notify(
				string.format("[LSP][%s] %s", formatter.name, err),
				vim.log.levels.ERROR,
				{ title = "LSP Format Error" }
			)
		end
	end
end

return M
