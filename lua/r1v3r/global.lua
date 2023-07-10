local global = {}
local osName = vim.loop.os_uname().sysname

function global:loadVariables()
	self.isMac = osName == "Darwin"
	self.isLinux = osName == "Linux"
	self.isWindows = osName == "Windows_NT"
	self.isWSL = vim.fn.has("wsl") == 1

	self.vimPath = vim.fn.stdpath("config")
	local pathSep = self.isWindows and "\\" or "/"
	local home = self.isWindows and os.getenv("USERPROFILE") or os.getenv("HOME")
	self.cacheDir = home .. pathSep .. ".cache" .. pathSep .. "nvim" .. pathSep
	self.pluginsDir = self.vimPath .. pathSep .. "lua" .. pathSep .. "plugins"
	self.home = home
	self.dataDir = string.format("%s/site/", vim.fn.stdpath("data"))
end

global:loadVariables()

return global
