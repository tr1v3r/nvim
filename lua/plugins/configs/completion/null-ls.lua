return function()
	local settings = require("r1v3r.settings")
	local null_ls = require("null-ls")
	local sources = require("completion.none-ls-sources").build(settings.null_ls_deps, null_ls)

	null_ls.setup({
		border = "rounded",
		debug = false,
		log_level = "warn",
		update_in_insert = false,
		sources = sources,
		default_timeout = settings.format_timeout,
	})

	-- Setup usercmd to register/deregister available source(s)
	local function _gen_completion()
		local sources_cont = null_ls.get_source({
			filetype = vim.api.nvim_get_option_value("filetype", { scope = "local" }),
		})
		local completion_items = {}
		for _, server in pairs(sources_cont) do
			table.insert(completion_items, server.name)
		end
		return completion_items
	end
	vim.api.nvim_create_user_command("NullLsToggle", function(opts)
		if vim.tbl_contains(_gen_completion(), opts.args) then
			null_ls.toggle({ name = opts.args })
		else
			vim.notify(
				string.format("[Null-ls] Unable to find any registered source named [%s].", opts.args),
				vim.log.levels.ERROR,
				{ title = "Null-ls Internal Error" }
			)
		end
	end, {
		nargs = 1,
		complete = _gen_completion,
	})

	require("completion.formatting").configure_format_on_save()
end
