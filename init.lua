-- Docs about lua in NeoVim
-- https://neovim.io/doc/user/lua.html
-- https://neovim.io/doc/user/lua-guide.html#lua-guide

if not vim.g.vscode then
    require("r1v3r")
end

local device_specificed = 1

if vim.fn.empty(vim.fn.glob('$HOME/.config/nvim/_device.vim')) == 1 then
    print('device vim not found')
else
    vim.cmd('source $HOME/.config/nvim/_device.vim')
end
