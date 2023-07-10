return function()
    vim.g.xtabline_lazy = 1
    vim.g.xtabline_settings = vim.g.xtabline_settings or {}
    vim.g.xtabline_settings.enable_mappings = 0
    vim.g.xtabline_settings.theme = 'codedark'
end
