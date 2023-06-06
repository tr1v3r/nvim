local ui = {}

ui["marko-cerovac/material.nvim"] = {
    lazy = false,
    priority = 1000,
    config = require("ui.material")
}
ui["Jint-lzxy/nvim"] = {
    lazy = false,
    branch = "refactor/syntax-highlighting",
    name = "catppuccin",
    config = require("ui.catppuccin")
}
ui["j-hui/fidget.nvim"] = {
    lazy = true,
    event = "LspAttach",
    config = require("ui.fidget")
}
ui["lewis6991/gitsigns.nvim"] = {
    lazy = true,
    event = {"CursorHold", "CursorHoldI"},
    config = require("ui.gitsigns")
}
ui["lukas-reineke/indent-blankline.nvim"] = {
    lazy = true,
    event = "BufReadPost",
    config = require("ui.indent-blankline")
}
ui["nvim-lualine/lualine.nvim"] = {
    lazy = true,
    event = {"BufReadPost", "BufAdd", "BufNewFile"},
    config = require("ui.lualine")
}
ui["zbirenbaum/neodim"] = {
    lazy = true,
    event = "LspAttach",
    branch = v2,
    config = require("ui.neodim")
}
ui["shaunsingh/nord.nvim"] = {
	lazy = true,
	config = require("ui.nord"),
}
ui["rcarriga/nvim-notify"] = {
	lazy = true,
	event = "VeryLazy",
	config = require("ui.notify"),
}
ui["folke/paint.nvim"] = {
	lazy = true,
	event = { "CursorHold", "CursorHoldI" },
	config = require("ui.paint"),
}
ui["karb94/neoscroll.nvim"] = {
    lazy = true,
    -- event = "BufReadPost",
    config = require("ui.neoscroll")
}
ui["dstein64/nvim-scrollview"] = {
	lazy = true,
	event = "BufReadPost",
	config = require("ui.scrollview"),
}
ui["edluffy/specs.nvim"] = {
	lazy = true,
	-- event = "CursorMoved",
	config = require("ui.specs"),
}

ui["nvim-tree/nvim-web-devicons"] = {
    lazy = true
}

return ui
