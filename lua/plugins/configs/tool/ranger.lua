return function()
    local ranger = require("ranger-nvim")
    ranger.setup({
        replace_netrw = true,
        enable_cmds = true,
        keybinds = {
            ["ov"] = ranger.OPEN_MODE.vsplit,
            ["oh"] = ranger.OPEN_MODE.split,
            ["ot"] = ranger.OPEN_MODE.tabedit,
            ["or"] = ranger.OPEN_MODE.rifle
        }
    })
end
