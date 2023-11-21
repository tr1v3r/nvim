-- Docs about lua in NeoVim
-- https://neovim.io/doc/user/lua.html
-- https://neovim.io/doc/user/lua-guide.html#lua-guide

-- Benchmark
-- go install -v github.com/rhysd/vim-startuptime@latest
-- startbenchmark: `vim-startuptime -vimpath nvim`

-- Initialize
-- run `sudo apt install python3-venv` for mason's plugins

-- load general config
if vim.g.vscode then
	require("r1v3r.ide.vscode")
else
	require("r1v3r")
end
