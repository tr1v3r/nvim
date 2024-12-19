local lang = {}
local keymaps = require("r1v3r.keymaps")

lang["kevinhwang91/nvim-bqf"] = {
	lazy = true,
	ft = "qf",
	config = require("lang.bqf"),
	dependencies = {
		{ "junegunn/fzf", build = ":call fzf#install()" },
	},
}
lang["fatih/vim-go"] = {
	lazy = true,
	ft = "go",
	build = ":GoInstallBinaries",
	config = require("lang.vim-go"),
}
lang["mrcjkb/rustaceanvim"] = {
	lazy = true,
	ft = "rust",
	version = "^3",
	config = require("lang.rust"),
	dependencies = { "nvim-lua/plenary.nvim" },
}
lang["Saecki/crates.nvim"] = {
	lazy = true,
	event = "BufReadPost Cargo.toml",
	config = require("lang.crates"),
	dependencies = { "nvim-lua/plenary.nvim" },
}
lang["iamcco/markdown-preview.nvim"] = {
	lazy = true,
	ft = "markdown",
	keys = keymaps.markdown_preview(),
	build = ":call mkdp#util#install()",
}
lang["chrisbra/csv.vim"] = {
	lazy = true,
	ft = "csv",
}
lang["lervag/vimtex"] = {
	lazy = true,
	ft = "tex",
	config = require("lang.vimtex"),
}

return lang
