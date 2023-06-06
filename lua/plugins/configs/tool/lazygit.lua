return function()
    vim.g.lazygit_floating_window_winblend = 0 -- transparency of floating window
    vim.g.lazygit_floating_window_scaling_factor = 1.0 -- scaling factor for floating window
    vim.g.lazygit_floating_window_border_chars = {'╭', '╮', '╰', '╯'} -- customize lazygit popup window corner characters
    vim.g.lazygit_use_neovim_remote = 1 -- for neovim-remote support
end
