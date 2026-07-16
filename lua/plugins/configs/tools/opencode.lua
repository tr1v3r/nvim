return function()
	-- @type opencode.Opts
	vim.g.opencode_opts = {
		-- Your configuration, if any — see `lua/opencode/config.lua`, or "goto definition".
	}

	-- Required for `opts.auto_reload`.
	vim.o.autoread = true
end
