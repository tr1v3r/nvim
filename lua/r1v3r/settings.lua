local settings = {}

----------------------------------------------------------------------
--                          Use Settings                            --
----------------------------------------------------------------------

-- Set it to false if you want to use https to update plugins and treesitter parsers.
---@type boolean
settings["use_ssh"] = true

-- Set it to false if you don't use copilot
---@type boolean
settings["use_copilot"] = true

----------------------------------------------------------------------
--                          Color Settings                          --
----------------------------------------------------------------------

-- Set the colorscheme to use here.
-- Available values are: `catppuccin`, `catppuccin-latte`, `catppucin-mocha`, `catppuccin-frappe`,
-- `catppuccin-macchiato`, `edge`, `nord`, `material`.
---@type string
settings["colorscheme"] = "monokai-pro-spectrum"

-- Set it to true if your terminal has transparent background.
---@type boolean
settings["transparent_background"] = true

-- Set background color to use here.
-- Useful if you would like to use a colorscheme that has a light and dark variant like `edge`.
-- Valid values are: `dark`, `light`.
---@type "dark"|"light"
settings["background"] = "dark"

-- Change the colors of the global palette here.
-- Settings will complete their replacement at initialization.
-- Parameters will be automatically completed as you type.
-- Example: { sky = "#04A5E5" }
---@type palette
---@diagnostic disable-next-line: missing-fields
settings["palette_overwrite"] = {}

-- Set the options for neovim's gui clients like `neovide` and `neovim-qt` here.
-- NOTE: Currently, only the following options related to the GUI are supported. Other entries will be IGNORED.
---@type { font_name: string, font_size: number }
settings["gui_config"] = {
	font_name = "Hack Nerd Font",
	font_size = 14,
}

-- Set the options specific to `neovide` here.
-- NOTE: You should remove the `neovide_` prefix (with trailing underscore) from all your entries below.
-- Check the follow link for all supported entries: https://neovide.dev/configuration.html
---@type table<string, boolean|number|string>
settings["neovide_config"] = {
	no_idle = true,
	refresh_rate = 120,
	cursor_vfx_mode = "railgun",
	cursor_vfx_opacity = 200.0,
	cursor_antialiasing = true,
	cursor_trail_length = 0.05,
	cursor_animation_length = 0.03,
	cursor_vfx_particle_speed = 20.0,
	cursor_vfx_particle_density = 5.0,
	cursor_vfx_particle_lifetime = 1.2,
}

----------------------------------------------------------------------
--                         Format Settings                          --
----------------------------------------------------------------------

-- Set it to false if there are no need to format on save.
---@type boolean
settings["format_on_save"] = true

-- Set format timeout here (in ms).
---@type number
settings["format_timeout"] = 1000

-- Set it to false if the notification after formatting is annoying.
---@type boolean
settings["format_notify"] = true

-- Set it to true if you prefer formatting ONLY the *changed lines* as defined by your version control system.
-- NOTE: This entry will only be respected if:
--  > The buffer to be formatted is under version control (Git or Mercurial);
--  > Any of the server attached to that buffer supports |DocumentRangeFormattingProvider| server capability.
-- Otherwise Neovim would fall back to format the whole buffer, and a warning will be issued.
---@type boolean
settings["format_modifications_only"] = false

-- Set the format disabled directories here, files under these dirs won't be formatted on save.
--- NOTE: Directories may contain regular expressions (grammar: vim). |regexp|
--- NOTE: Directories are automatically normalized. |vim.fs.normalize()|
---@type string[]
settings["format_disabled_dirs"] = { "~/format_disabled_dir" }

-- Servers in this list will skip setting formatting capabilities if rhs is true.
---@type table<string, boolean>
settings["format_block_formatters"] = {
	lua_ls = true,
	tsserver = true,
	clangd = true,
	pylsp = true,
	gopls = true,
}

-- Filetypes in this list will skip lsp formatting if rhs is true.
---@type table<string, boolean>
settings["format_block_filetypes"] = {
	-- lua = true
}

----------------------------------------------------------------------
--                          Deps Settings                           --
----------------------------------------------------------------------

-- Set the language servers that will be installed during bootstrap here.
-- check the below link for all the supported LSPs:
-- https://github.com/neovim/nvim-lspconfig/tree/master/lua/lspconfig/server_configurations
---@type string[]
settings["lsp_deps"] = {
	"bashls",
	"clangd",
	"html",
	"jsonls",
	"lua_ls",
	"pylsp",
	"gopls",
	-- "gopls@v0.15.3", -- for go 1.19-
}

-- Set the Treesitter deps that will be installed and configured during boot.
-- Check the below link for all supported languages:
-- https://github.com/nvim-treesitter/nvim-treesitter#supported-languages
---@type string[]
settings["treesitter_deps"] = {
	"bash",
	"c",
	"cpp",
	"css",
	"go",
	"gomod",
	"html",
	"javascript",
	"json",
	"latex",
	"lua",
	"make",
	"markdown",
	"markdown_inline",
	"python",
	"rust",
	"typescript",
	"vimdoc",
	"vue",
	"yaml",
}

-- Set the general-purpose servers that will be installed during bootstrap here.
-- Check the below link for all supported sources.
-- in `code_actions`, `completion`, `diagnostics`, `formatting`, `hover` folders:
-- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins
---@type string[]
settings["null_ls_deps"] = {
	"prettier",
	"shfmt",
	"stylua",
	"vint",
	"goimports",
	"goimports-reviser",
	-- "rustfmt",
	-- "clang_format",
}

-- Set the Debug Adapter Protocal (DAP) clients that wil be installed and configured during bootstrap.
-- Check the below link for all supported DAPs:
-- https://github.com/jay-babu/mason-nvim-dap.nvim/blob/main/lua/mason-nvim-dap/mappings/source.lua
---@type string[]
settings["dap_deps"] = {
	"codelldb", -- C-Family
	"delve", -- Go
	"python", -- Python (debugpy)
}

settings["private_plugins_dir"] = require("r1v3r.global").vim_path .. "/plugins"

----------------------------------------------------------------------
--                          Other Settings                          --
----------------------------------------------------------------------

-- Set it to false if diagnostics virtual lines is annoying.
-- If disabled, you may browse lsp diagnostics using trouble.nvim (press `gt` to toggle it).
---@type boolean
settings["diagnostics_virtual_lines"] = true

-- Set it to one of the values below if you want to change the visible severity level of lsp diagnostics.
-- Priority: `Error` > `Warning` > `Information` > `Hint`.
--  > e.g. if you set this option to `Warning`, only lsp warnings and errors will be shown.
-- NOTE: This entry only works when `diagnostics_virtual_text` is true.
---@type "Error"|"Warning"|"Information"|"Hint"
settings["diagnostics_level"] = "Hint"

-- Set the command for handling external URLs here. The executable must be available on your $PATH.
-- This entry is IGNORED on Windows and macOS, which have their default handlers builtin.
---@type string
settings["external_browser"] = "chrome-cli open"

-- Set it to false if you don't use nvim to open big files.
---@type boolean
settings["load_big_files_faster"] = true

-- settings["dashboard_image"] = {
-- 	[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⠀⢄⢢⢒⢤⢠⣐⢠⢠⡀⡄⡠⡀⡄⡀⠄⡀⢀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
-- 	[[⠀⠀⠀⠀⠀⠀⠀⠠⢐⢨⢔⢜⢭⢪⢪⢪⢪⢪⢪⢪⢲⢱⢱⢱⢱⢱⢍⢇⢇⢗⢜⢔⢔⣀⠀⠀⠀⠀⠀⠀]],
-- 	[[⠀⠀⠀⠀⢀⠠⠁⡪⢸⢸⢸⢸⢸⢸⢸⢸⢜⢜⢜⢜⢜⢜⢜⢜⢜⢜⢜⢜⢜⢜⢜⢜⢜⢜⢜⠄⠀⠀⠀⠀]],
-- 	[[⠀⠀⠀⠀⠄⠀⠅⢌⢆⢇⢇⢇⢇⢇⢇⢇⢇⢧⢳⢱⢕⢕⢕⢕⢕⢕⢕⢕⢕⢕⢕⢕⢕⢕⢕⢭⠀⠀⠀⠀]],
-- 	[[⠀⠀⠀⠂⢀⠡⢈⠆⠃⠃⡁⠅⠡⠡⠡⡉⡊⠪⡪⡪⡪⡪⡣⡳⡱⡕⣕⢕⢕⢕⠕⠕⠕⠵⢱⡱⢅⠀⠀⠀]],
-- 	[[⠀⠀⠀⠂⠀⠐⠀⠄⠈⠀⠀⠀⠀⠀⠀⠀⠀⠁⠊⢎⢮⢪⡪⡪⡪⡪⡪⠊⠁⠀⠀⠀⢀⢀⢀⠈⠑⠀⠀⠀]],
-- 	[[⠀⠀⠀⠠⠈⠀⠠⠐⡐⢕⢕⢕⢬⠢⣄⢀⠀⠀⠀⠀⡱⡱⡱⡹⡸⡪⠀⠀⡀⡰⡌⡎⡎⡎⡎⡎⣖⠀⠀⠀]],
-- 	[[⠀⠀⠀⠀⠄⠂⠀⠁⠌⡘⠜⡜⡜⡜⡜⡜⡔⠄⠀⠀⠑⢕⢕⢕⢕⢝⢨⢰⢪⢪⢪⡪⡪⣪⢪⡪⡪⡃⠀⠀]],
-- 	[[⠀⠀⠀⢀⠀⠀⠀⠐⠀⠀⠂⠀⠀⠀⠀⠈⠈⠁⠀⠄⠀⡜⡜⡕⣕⢕⢜⠜⠘⠈⠐⠈⠈⠀⠑⢕⢕⠅⠀⠀]],
-- 	[[⠀⠀⠀⠀⠐⠀⢀⣀⠀⠀⠀⠀⠀⡀⢀⠀⡀⠀⢀⢀⠪⡘⡜⡜⡜⡜⣅⠀⡀⠀⡀⠀⡀⡀⡀⣀⢑⠅⠀⠀]],
-- 	[[⠀⠀⠀⠀⠄⠪⡑⡎⡭⡣⡣⣓⣒⢲⢸⢸⢸⢱⢱⠡⡑⠠⢣⢣⢣⢣⢣⢳⢸⢢⢲⢰⢔⢔⢜⢔⢕⢅⠀⠀]],
-- 	[[⠀⠀⠀⠠⠐⠀⠌⢈⠊⡊⠎⡖⡜⡜⡜⡜⡜⡜⡜⠜⠄⠅⡑⡕⡕⣕⢕⢕⢕⢕⢕⢕⢕⢕⢕⢕⢕⢕⠀⠀]],
-- 	[[⠀⠀⠀⠀⠀⠀⢀⠀⠠⠀⠨⠐⡱⠱⡱⠑⠅⠡⡨⡪⡡⠁⠂⢣⢣⢣⢣⢳⢱⢕⢕⢕⢕⢕⢕⢕⢕⢕⠅⠀]],
-- 	[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⠀⠂⠄⠁⢀⠠⡰⠈⠈⠂⠀⠈⠀⠀⠱⢱⠱⠣⢣⢣⢳⠱⡕⣕⢕⢕⢕⢕⠁⠀]],
-- 	[[⠀⠀⠀⠀⠀⠐⡀⠀⠈⠀⠈⢀⠀⡐⠔⡕⢜⢔⠈⠠⠀⠀⠀⠀⠈⠈⠸⡢⡣⡣⡣⡣⡢⡈⠈⠣⢳⠑⠀⠀]],
-- 	[[⠀⠀⠀⠀⠀⠀⠘⡀⠀⢀⠀⠀⠑⠌⢌⠪⠢⠱⠱⠐⠀⠀⠀⡠⡄⠀⠀⠘⠸⢜⢎⠮⠊⠀⢰⠅⢸⠁⠀⠀]],
-- 	[[⠀⠀⠀⠀⠀⠀⠀⠨⠀⠀⠢⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠔⠕⠕⠆⠁⠀⠀⠀⠀⠀⠀⡰⡕⢁⠎⠀⠀⠀]],
-- 	[[⠀⠀⠀⠀⠀⠀⠀⠀⠑⡀⠀⠈⠐⠠⠠⠠⠠⡀⢄⠄⡄⢄⢄⢄⠄⡠⢠⢠⢠⡈⡖⡕⡝⡜⠄⡪⠂⠀⠀⠀]],
-- 	[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠢⡀⠀⠀⠀⠀⠀⠀⠀⢀⠀⠄⠀⠨⠈⠌⡪⣘⢔⢕⢕⢕⢕⠅⡜⡜⠀⠀⠀⠀]],
-- 	[[⠀⠀⠀⠀⠀⠀⠀⠀⡀⠀⠀⠑⠥⡀⠀⠂⢀⠡⢐⢀⢄⢐⠀⠀⠀⢰⢸⢸⢸⢸⢸⢸⢸⢸⠸⠀⠀⠀⠀⠀]],
-- 	[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠊⢆⠈⠀⡂⢆⢢⠱⡐⠀⠀⠀⠈⡎⡎⡎⡎⡎⡇⡇⡇⠃⠀⠀⠀⠀⠀]],
-- 	[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠡⢀⠨⠘⡜⡜⡌⠀⠀⠀⠀⡸⡸⡸⡸⡸⡸⡘⠀⠀⠀⠀⠀⠀⠀]],
-- 	[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠂⡑⢕⠁⠀⠀⠀⡎⡎⡎⡮⡪⠊⠀⠀⠀⠀⠀⠀⠀⠀]],
-- 	[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⠄⠀⠀⠀⠀⠀⠀⠄⠁⠀⠀⠀⡇⡇⠇⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
-- }

settings["dashboard_image"] = {
	[[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
	[[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠋⣠⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
	[[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣡⣾⣿⣿⣿⣿⣿⢿⣿⣿⣿⣿⣿⣿⣟⠻⣿⣿⣿⣿⣿⣿⣿⣿]],
	[[⣿⣿⣿⣿⣿⣿⣿⣿⡿⢫⣷⣿⣿⣿⣿⣿⣿⣿⣾⣯⣿⡿⢧⡚⢷⣌⣽⣿⣿⣿⣿⣿⣶⡌⣿⣿⣿⣿⣿⣿]],
	[[⣿⣿⣿⣿⣿⣿⣿⣿⠇⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣮⣇⣘⠿⢹⣿⣿⣿⣿⣿⣻⢿⣿⣿⣿⣿⣿]],
	[[⣿⣿⣿⣿⣿⣿⣿⣿⠀⢸⣿⣿⡇⣿⣿⣿⣿⣿⣿⣿⣿⡟⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⣻⣿⣿⣿⣿]],
	[[⣿⣿⣿⣿⣿⣿⣿⡇⠀⣬⠏⣿⡇⢻⣿⣿⣿⣿⣿⣿⣿⣷⣼⣿⣿⣸⣿⣿⣿⣿⣿⣿⣿⣿⣿⢻⣿⣿⣿⣿]],
	[[⣿⣿⣿⣿⣿⣿⣿⠀⠈⠁⠀⣿⡇⠘⡟⣿⣿⣿⣿⣿⣿⣿⣿⡏⠿⣿⣟⣿⣿⣿⣿⣿⣿⣿⣿⣇⣿⣿⣿⣿]],
	[[⣿⣿⣿⣿⣿⣿⡏⠀⠀⠐⠀⢻⣇⠀⠀⠹⣿⣿⣿⣿⣿⣿⣩⡶⠼⠟⠻⠞⣿⡈⠻⣟⢻⣿⣿⣿⣿⣿⣿⣿]],
	[[⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⢿⠀⡆⠀⠘⢿⢻⡿⣿⣧⣷⢣⣶⡃⢀⣾⡆⡋⣧⠙⢿⣿⣿⣟⣿⣿⣿⣿]],
	[[⣿⣿⣿⣿⣿⣿⡿⠀⠀⠀⠀⠀⠀⠀⡥⠂⡐⠀⠁⠑⣾⣿⣿⣾⣿⣿⣿⡿⣷⣷⣿⣧⣾⣿⣿⣿⣿⣿⣿⣿]],
	[[⣿⣿⡿⣿⣍⡴⠆⠀⠀⠀⠀⠀⠀⠀⠀⣼⣄⣀⣷⡄⣙⢿⣿⣿⣿⣿⣯⣶⣿⣿⢟⣾⣿⣿⢡⣿⣿⣿⣿⣿]],
	[[⣿⡏⣾⣿⣿⣿⣷⣦⠀⠀⠀⢀⡀⠀⠀⠠⣭⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠟⣡⣾⣿⣿⢏⣾⣿⣿⣿⣿⣿]],
	[[⣿⣿⣿⣿⣿⣿⣿⣿⡴⠀⠀⠀⠀⠀⠠⠀⠰⣿⣿⣿⣷⣿⠿⠿⣿⣿⣭⡶⣫⠔⢻⢿⢇⣾⣿⣿⣿⣿⣿⣿]],
	[[⣿⣿⣿⡿⢫⣽⠟⣋⠀⠀⠀⠀⣶⣦⠀⠀⠀⠈⠻⣿⣿⣿⣾⣿⣿⣿⣿⡿⣣⣿⣿⢸⣾⣿⣿⣿⣿⣿⣿⣿]],
	[[⡿⠛⣹⣶⣶⣶⣾⣿⣷⣦⣤⣤⣀⣀⠀⠀⠀⠀⠀⠀⠉⠛⠻⢿⣿⡿⠫⠾⠿⠋⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
	[[⢀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣀⡆⣠⢀⣴⣏⡀⠀⠀⠀⠉⠀⠀⢀⣠⣰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
	[[⠿⠛⠛⠛⠛⠛⠛⠻⢿⣿⣿⣿⣿⣯⣟⠷⢷⣿⡿⠋⠀⠀⠀⠀⣵⡀⢠⡿⠋⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
	[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠛⢿⣿⣿⠂⠀⠀⠀⠀⠀⢀⣽⣿⣿⣿⣿⣿⣿⣿⣍⠛⠿⣿⣿⣿⣿⣿⣿]],
}

--	 {[[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢿⣿⡻⡝⡭⡛⡟⠯⡟⡟⢿⢻⢟⢿⢻⢿⣻⢿⡿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
--	  [[⣿⣿⣿⣿⣿⣿⣿⣟⡯⡗⡫⡣⡒⡕⡕⡕⡕⡕⡕⡕⡍⡎⡎⡎⡎⡎⡲⡸⡸⡨⡣⡫⡫⠿⣿⣿⣿⣿⣿⣿]],
--	  [[⣿⣿⣿⣿⡿⣟⣾⢕⡇⡇⡇⡇⡇⡇⡇⡇⡣⡣⡣⡣⡣⡣⡣⡣⡣⡣⡣⡣⡣⡣⡣⡣⡣⡣⡣⣻⣿⣿⣿⣿]],
--	  [[⣿⣿⣿⣿⣻⣿⣺⡳⡹⡸⡸⡸⡸⡸⡸⡸⡸⡘⡌⡎⡪⡪⡪⡪⡪⡪⡪⡪⡪⡪⡪⡪⡪⡪⡪⡒⣿⣿⣿⣿]],
--	  [[⣿⣿⣿⣽⡿⣞⡷⣹⣼⣼⢾⣺⣞⣞⣞⢶⢵⣕⢕⢕⢕⢕⢜⢌⢎⢪⠪⡪⡪⡪⣪⣪⣪⣊⡎⢎⡺⣿⣿⣿]],
--	  [[⣿⣿⣿⣽⣿⣯⣿⣻⣷⣿⣿⣿⣿⣿⣿⣿⣿⣾⣵⡱⡑⡕⢕⢕⢕⢕⢕⣵⣾⣿⣿⣿⡿⡿⡿⣷⣮⣿⣿⣿]],
--	  [[⣿⣿⣿⣟⣷⣿⣟⣯⢯⡪⡪⡪⡓⣝⠻⡿⣿⣿⣿⣿⢎⢎⢎⢆⢇⢕⣿⣿⢿⢏⢳⢱⢱⢱⢱⢱⠩⣿⣿⣿]],
--	  [[⣿⣿⣿⣿⣻⣽⣿⣾⣳⢧⣣⢣⢣⢣⢣⢣⢫⣻⣿⣿⣮⡪⡪⡪⡪⡢⡗⡏⡕⡕⡕⢕⢕⠕⡕⢕⢕⢼⣿⣿]],
--	  [[⣿⣿⣿⡿⣿⣿⣿⣯⣿⣿⣽⣿⣿⣿⣿⣷⣷⣾⣿⣻⣿⢣⢣⢪⠪⡪⡣⣣⣧⣷⣯⣷⣷⣿⣮⡪⡪⣺⣿⣿]],
--	  [[⣿⣿⣿⣿⣯⣿⡿⠿⣿⣿⣿⣿⣿⢿⡿⣿⢿⣿⡿⡿⣕⢧⢣⢣⢣⢣⠺⣿⢿⣿⢿⣿⢿⢿⢿⠿⡮⣺⣿⣿]],
--	  [[⣿⣿⣿⣿⣻⣕⢮⢱⢒⢜⢜⠬⠭⡍⡇⡇⡇⡎⡎⣞⢮⣟⡜⡜⡜⡜⡜⡌⡇⡝⡍⡏⡫⡫⡣⡫⡪⡺⣿⣿]],
--	  [[⣿⣿⣿⣟⣯⣿⣳⡷⣵⢵⣱⢩⢣⢣⢣⢣⢣⢣⢣⣣⣻⣺⢮⢪⢪⠪⡪⡪⡪⡪⡪⡪⡪⡪⡪⡪⡪⡪⣿⣿]],
--	  [[⣿⣿⣿⣿⣿⣿⡿⣿⣟⣿⣗⣯⢎⣎⢎⣮⣺⣞⢗⢕⢞⣾⣽⡜⡜⡜⡜⡌⡎⡪⡪⡪⡪⡪⡪⡪⡪⡪⣺⣿]],
--	  [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣯⣿⣽⣻⣾⡿⣟⢏⣷⣷⣽⣿⣷⣿⣿⣎⡎⣎⣜⡜⡜⡌⣎⢪⠪⡪⡪⡪⡪⣾⣿]],
--	  [[⣿⣿⣿⣿⣿⣯⢿⣿⣷⣿⣷⡿⣿⢯⣫⢪⡣⡫⣷⣟⣿⣿⣿⣿⣷⣷⣇⢝⢜⢜⢜⢜⢝⢷⣷⣜⡌⣮⣿⣿]],
--	  [[⣿⣿⣿⣿⣿⣿⣧⢿⣿⡿⣿⣿⣮⣳⡳⣕⣝⣎⣎⣯⣿⣿⣿⢟⢻⣿⣿⣧⣇⡣⡱⣑⣵⣿⡏⣺⡇⣾⣿⣿]],
--	  [[⣿⣿⣿⣿⣿⣿⣿⣗⣿⣿⣝⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣫⣪⣪⣹⣾⣿⣿⣿⣿⣿⣿⢏⢪⡾⣱⣿⣿⣿]],
--	  [[⣿⣿⣿⣿⣿⣿⣿⣿⣮⢿⣿⣷⣯⣟⣟⣟⣟⢿⡻⣻⢻⡻⡻⡻⣻⢟⡟⡟⡟⢷⢩⢪⢢⢣⣻⢕⣽⣿⣿⣿]],
--	  [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣝⢿⣿⣿⣿⣿⣿⣿⣿⡿⣿⣻⣿⣗⣷⣳⢕⠧⡫⡪⡪⡪⡪⣺⢣⢣⣿⣿⣿⣿]],
--	  [[⣿⣿⣿⣿⣿⣿⣿⣿⢿⣿⣿⣮⣚⢿⣿⣽⡿⣞⡯⡿⡻⡯⣿⣿⣿⡏⡇⡇⡇⡇⡇⡇⡇⡇⣇⣿⣿⣿⣿⣿]],
--	  [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣵⡹⣷⣿⢽⡹⡝⣎⢯⣿⣿⣿⣷⢱⢱⢱⢱⢱⢸⢸⢸⣼⣿⣿⣿⣿⣿]],
--	  [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣞⡿⣗⣧⢣⢣⢳⣿⣿⣿⣿⢇⢇⢇⢇⢇⢇⢧⣿⣿⣿⣿⣿⣿⣿]],
--	  [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣽⢮⡪⣾⣿⣿⣿⢱⢱⢱⢑⢕⣵⣿⣿⣿⣿⣿⣿⣿⣿]],
--	  [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢿⣻⣿⣿⣿⣿⣿⣿⣻⣾⣿⣿⣿⢸⢸⣸⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]]}
return settings
