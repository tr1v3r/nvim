local function setup_textobjects()
	require("nvim-treesitter-textobjects").setup({
		select = { lookahead = true },
		move = { set_jumps = true },
	})

	local select = require("nvim-treesitter-textobjects.select")
	local move = require("nvim-treesitter-textobjects.move")

	local selections = {
		af = "@function.outer",
		kf = "@function.inner",
		ac = "@class.outer",
		kc = "@class.inner",
	}
	for lhs, query in pairs(selections) do
		local capture = query
		vim.keymap.set({ "x", "o" }, lhs, function()
			select.select_textobject(capture, "textobjects")
		end, { desc = "Treesitter select " .. capture })
	end

	local motions = {
		goto_next_start = {
			["]["] = "@block.outer",
			["]f"] = "@function.outer",
			["]m"] = "@class.outer",
		},
		goto_next_end = {
			["]]"] = "@block.outer",
			["]F"] = "@function.outer",
			["]M"] = "@class.outer",
		},
		goto_previous_start = {
			["[["] = "@block.outer",
			["[f"] = "@function.outer",
			["[m"] = "@class.outer",
		},
		goto_previous_end = {
			["[]"] = "@block.outer",
			["[F"] = "@function.outer",
			["[M"] = "@class.outer",
		},
	}
	for method, mappings in pairs(motions) do
		for lhs, query in pairs(mappings) do
			local motion = method
			local capture = query
			vim.keymap.set({ "n", "x", "o" }, lhs, function()
				move[motion](capture, "textobjects")
			end, { desc = "Treesitter move to " .. capture })
		end
	end
end

return function()
	local treesitter = require("nvim-treesitter")
	local parsers = require("r1v3r.settings").treesitter_deps

	treesitter.setup()
	treesitter.install(parsers)

	-- The parser is named "latex", while Neovim detects TeX buffers as "tex".
	vim.treesitter.language.register("latex", { "tex", "plaintex" })

	vim.api.nvim_create_autocmd("FileType", {
		group = vim.api.nvim_create_augroup("r1v3r_treesitter", { clear = true }),
		callback = function(args)
			if args.match == "vim" then
				return
			end

			local ok, is_large_file =
				pcall(vim.api.nvim_buf_get_var, args.buf, "bigfile_disable_treesitter")
			if ok and is_large_file then
				return
			end

			local language = vim.treesitter.language.get_lang(args.match)
			if not language or not vim.treesitter.language.add(language) then
				return
			end

			vim.treesitter.start(args.buf, language)
			vim.wo.foldmethod = "expr"
			vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
			vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		end,
	})

	vim.keymap.set({ "n", "x" }, "<CR>", function()
		vim.treesitter.select("parent")
	end, { desc = "Treesitter expand selection" })
	vim.keymap.set("x", "<BS>", function()
		vim.treesitter.select("child")
	end, { desc = "Treesitter shrink selection" })

	setup_textobjects()
end
