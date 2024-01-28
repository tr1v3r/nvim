return function()
	-- https://zjp-cn.github.io/neovim0.6-blogs/nvim/luasnip/doc1.html
	-- https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md

	local snippet_path = vim.fn.stdpath("config") .. "/snips/"
	-- if not vim.tbl_contains(vim.opt.rtp:get(), snippet_path) then
	-- 	vim.opt.rtp:append(snippet_path)
	-- end

	require("luasnip").config.set_config({
		history = true,
		update_events = "TextChanged,TextChangedI",
		delete_check_events = "TextChanged,InsertLeave",
	})
	require("luasnip.loaders.from_lua").lazy_load({ paths = { snippet_path .. "lua" } })
	require("luasnip.loaders.from_vscode").lazy_load({ paths = { snippet_path } })
	require("luasnip.loaders.from_vscode").lazy_load()
	require("luasnip.loaders.from_snipmate").lazy_load()
end
