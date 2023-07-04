return function()
	local colors = require("helper").get_palette()
	local icons = {
		diagnostics = require("r1v3r.icons").get("diagnostics", true),
		misc = require("r1v3r.icons").get("misc", true),
		ui = require("r1v3r.icons").get("ui", true),
	}

	local function escape_status()
		local ok, m = pcall(require, "better_escape")
		return ok and m.waiting and icons.misc.EscapeST or ""
	end

	local _cache = { context = "", bufnr = -1 }
	local function lspsaga_symbols()
		local exclude = {
			["terminal"] = true,
			["toggleterm"] = true,
			["prompt"] = true,
			["NvimTree"] = true,
			["help"] = true,
		}
		if vim.api.nvim_win_get_config(0).zindex or exclude[vim.bo.filetype] then
			return "" -- Excluded filetypes
		else
			local currbuf = vim.api.nvim_get_current_buf()
			local ok, lspsaga = pcall(require, "lspsaga.symbolwinbar")
			if ok and lspsaga:get_winbar() ~= nil then
				_cache.context = lspsaga:get_winbar()
				_cache.bufnr = currbuf
			elseif _cache.bufnr ~= currbuf then
				_cache.context = "" -- Reset [invalid] cache (usually from another buffer)
			end

			return _cache.context
		end
	end

	local function diff_source()
		local gitsigns = vim.b.gitsigns_status_dict
		if gitsigns then
			return {
				added = gitsigns.added,
				modified = gitsigns.changed,
				removed = gitsigns.removed,
			}
		end
	end

	local function get_cwd()
		local cwd = vim.fn.getcwd()
		local is_windows = require("r1v3r.global").is_windows
		if not is_windows then
			local home = require("r1v3r.global").home
			if cwd:find(home, 1, true) == 1 then
				cwd = "~" .. cwd:sub(#home + 1)
			end
		end
		return icons.ui.RootFolderOpened .. cwd
	end

    local function winbar_filepath()
		local exclude = {
			["terminal"] = true,
			["toggleterm"] = true,
			["prompt"] = true,
			["NvimTree"] = true,
			-- ["help"] = true,
		}

        if exclude[vim.bo.filetype] then
            return ""
        end

        local path = vim.api.nvim_buf_get_name(0)
            :gsub("^" .. vim.fn.getcwd() .. "/", "")
            :gsub("/", icons.ui.ArrowClosed)
        if path ~= "" then
            return icons.ui.FileTree .. path
        end
        return path
    end

	local mini_sections = {
		lualine_a = { "filetype" },
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	}
	local outline = {
		sections = mini_sections,
		filetypes = { "lspsagaoutline" },
	}
	local diffview = {
		sections = mini_sections,
		filetypes = { "DiffviewFiles" },
	}

	local function python_venv()
		local function env_cleanup(venv)
			if string.find(venv, "/") then
				local final_venv = venv
				for w in venv:gmatch("([^/]+)") do
					final_venv = w
				end
				venv = final_venv
			end
			return venv
		end

		if vim.bo.filetype == "python" then
			local venv = os.getenv("CONDA_DEFAULT_ENV")
			if venv then
				return string.format("%s", env_cleanup(venv))
			end
			venv = os.getenv("VIRTUAL_ENV")
			if venv then
				return string.format("%s", env_cleanup(venv))
			end
		end
		return ""
	end

	require("lualine").setup({
		options = {
			icons_enabled = true,
			theme = "catppuccin",
			disabled_filetypes = {},
			component_separators = "|",
			section_separators = { left = "", right = "" },
		},
		sections = {
			lualine_a = { { "mode" } },
			lualine_b = { { "branch" }, { "diff", source = diff_source } },
			lualine_c = { lspsaga_symbols },
			lualine_x = {
				{ escape_status },
				{
					"diagnostics",
					sources = { "nvim_diagnostic" },
					symbols = {
						error = icons.diagnostics.Error,
						warn = icons.diagnostics.Warning,
						info = icons.diagnostics.Information,
						hint = icons.diagnostics.Hint_alt,
					},
				},
				{ get_cwd },
			},
			lualine_y = {
				{ "filetype", colored = true, icon_only = true },
				{ python_venv },
				{ "encoding" },
				{
					"fileformat",
					icons_enabled = true,
					symbols = {
						-- unix = "", -- e712
						-- dos = "", -- e70f
						-- mac = "", -- e711
						unix = "LF",
						dos = "CRLF",
						mac = "CR",
					},
				},
			},
			lualine_z = { "progress", "location" },
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = { {'filename', path = 1 } },
			lualine_x = { "location" },
			lualine_y = {},
			lualine_z = {},
		},
		tabline = {},
		-- winbar = { lualine_c = {'filename', path = 1 } }, cannot ignore filetype NvimTree
		winbar = { lualine_c = { winbar_filepath } },
		inactive_winbar = { lualine_c = { winbar_filepath } },
		extensions = {
			"quickfix",
			"nvim-tree",
			"nvim-dap-ui",
			"toggleterm",
			"fugitive",
			outline,
			diffview,
		},
	})

	-- Properly set background color for lspsaga
	local winbar_bg = require("helper").hl_to_rgb("StatusLine", true, colors.mantle)
	for _, hlGroup in pairs(require("lspsaga.lspkind").get_kind_group()) do
		require("helper").extend_hl(hlGroup, { bg = winbar_bg })
	end
end
