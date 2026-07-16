local bufnr = vim.api.nvim_get_current_buf()
local filetype = vim.bo[bufnr].filetype

vim.v.errmsg = ""

local highlighter_started = vim.wait(2000, function()
	return vim.treesitter.highlighter.active[bufnr] ~= nil
end, 20)

assert(highlighter_started, "Treesitter highlighter did not start for " .. filetype)

local parser = vim.treesitter.get_parser(bufnr)
parser:parse(true)
vim.wait(200)

assert(vim.v.errmsg == "", vim.v.errmsg)

if filetype == "markdown" then
	local languages = {}
	parser:for_each_tree(function(_, language_tree)
		languages[language_tree:lang()] = true
	end)
	assert(languages.lua, "Markdown Lua injection was not parsed")
end
