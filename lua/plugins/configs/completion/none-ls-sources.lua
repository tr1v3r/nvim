local M = {}

local prettier_filetypes = {
	"css",
	"html",
	"javascript",
	"javascriptreact",
	"json",
	"markdown",
	"scss",
	"thrift",
	"typescript",
	"typescriptreact",
	"vue",
	"yaml",
}

M.registry = {
	prettier = {
		filetypes = prettier_filetypes,
		build = function(null_ls)
			return null_ls.builtins.formatting.prettier.with({ filetypes = prettier_filetypes })
		end,
	},
	shfmt = {
		filetypes = { "sh" },
		build = function(null_ls)
			return null_ls.builtins.formatting.shfmt
		end,
	},
	stylua = {
		filetypes = { "lua" },
		build = function(null_ls)
			return null_ls.builtins.formatting.stylua.with({
				extra_args = require("completion.formatters.stylua"),
			})
		end,
	},
	vint = {
		filetypes = { "vim" },
		build = function(null_ls)
			return null_ls.builtins.diagnostics.vint
		end,
	},
	goimports = {
		filetypes = { "go" },
		build = function(null_ls)
			return null_ls.builtins.formatting.goimports
		end,
	},
	["goimports-reviser"] = {
		filetypes = { "go" },
		build = function(null_ls)
			return null_ls.builtins.formatting.goimports_reviser.with({
				extra_args = require("completion.formatters.goimports-reviser"),
			})
		end,
	},
	clang_format = {
		filetypes = { "c", "cpp" },
		build = function(null_ls)
			return null_ls.builtins.formatting.clang_format.with({
				extra_args = require("completion.formatters.clang_format"),
			})
		end,
	},
}

function M.filetypes(enabled_sources)
	local filetypes = {}
	local seen = {}
	for _, name in ipairs(enabled_sources) do
		local source = M.registry[name]
		if source then
			for _, filetype in ipairs(source.filetypes) do
				if not seen[filetype] then
					seen[filetype] = true
					table.insert(filetypes, filetype)
				end
			end
		end
	end
	table.sort(filetypes)
	return filetypes
end

function M.build(enabled_sources, null_ls)
	local sources = {}
	for _, name in ipairs(enabled_sources) do
		local source = M.registry[name]
		if source then
			table.insert(sources, source.build(null_ls))
		else
			vim.notify(
				string.format("[none-ls] Unknown source in settings.null_ls_deps: %s", name),
				vim.log.levels.WARN,
				{ title = "none-ls configuration" }
			)
		end
	end
	return sources
end

return M
