-- Docs about lua in NeoVim
-- https://neovim.io/doc/user/lua.html
-- https://neovim.io/doc/user/lua-guide.html#lua-guide

-- Benchmark
-- go install -v github.com/rhysd/vim-startuptime@latest
-- startbenchmark: `vim-startuptime -vimpath nvim`

-- load general config
if vim.g.vscode then
	require("r1v3r.ide.vscode")
else
	require("r1v3r")
end

-- load device config
DeviceSpecificed = 1
local deviceConfig = os.getenv("HOME") .. "/.config/nvim/_device.lua"
if vim.fn.empty(vim.fn.glob(deviceConfig)) == 1 then
	print("device lua not found")
else
    dofile(deviceConfig)
end
