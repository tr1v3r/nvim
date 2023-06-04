local ui = {}

ui["marko-cerovac/material.nvim"] = {
    lazy = false,
    priority = 1000,
    config = require("ui.material")
}

ui["nvim-tree/nvim-web-devicons"] = {
    lazy = true
}

return ui
