local tool = {}

tool["dstein64/vim-startuptime"] = {
    -- lazy-load on a command
    cmd = "StartupTime",
    -- init is called during startup. Configuration for vim plugins typically should be set in an init function
    init = function()
        vim.g.startuptime_tries = 10
    end
}
tool["nvim-tree/nvim-tree.lua"] = {
    lazy = true,
    cmd = {"NvimTreeToggle", "NvimTreeOpen", "NvimTreeFindFile", "NvimTreeFindFileToggle", "NvimTreeRefresh"},
    config = require("tool.nvim-tree")
}
tool["gelguy/wilder.nvim"] = {
    lazy = true,
    event = "CmdlineEnter",
    config = require("tool.wilder"),
    dependencies = {"romgrk/fzy-lua-native"}
}
tool["tpope/vim-fugitive"] = {
    lazy = true,
    cmd = {"Git", "G"}
}
tool["kdheepak/lazygit.nvim"] = {
    lazy = true,
    cmd = "LazyGit",
    config = require("tool.lazygit"),
    -- optional for floating window border decoration
    dependencies = {"nvim-lua/plenary.nvim"}
}

-- 	-- Unmanaged plugin (manually installed and updated)
-- 	{ dir = "~/my-prototype-plugin" },
-- 	},

return tool
