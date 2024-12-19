local tool = {}
local keymaps = require("r1v3r.keymaps")

tool["dstein64/vim-startuptime"] = {
	-- lazy-load on a command
	cmd = "StartupTime",
	-- init is called during startup. Configuration for vim plugins typically should be set in an init function
	init = function()
		vim.g.startuptime_tries = 10
	end,
}
tool["nvim-tree/nvim-tree.lua"] = {
	lazy = true,
	cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeFindFile", "NvimTreeFindFileToggle", "NvimTreeRefresh" },
	keys = keymaps.nvim_tree(),
	config = require("tool.nvim-tree"),
}
tool["tpope/vim-fugitive"] = {
	lazy = true,
	keys = keymaps.vim_fugitive(),
	cmd = { "Git", "G" },
}
tool["gelguy/wilder.nvim"] = {
	lazy = true,
	event = "CmdlineEnter",
	config = require("tool.wilder"),
	dependencies = { "romgrk/fzy-lua-native" },
}
tool["kdheepak/lazygit.nvim"] = {
	lazy = true,
	cmd = "LazyGit",
	keys = keymaps.lazygit(),
	config = require("tool.lazygit"),
	-- optional for floating window border decoration
	dependencies = { "nvim-lua/plenary.nvim" },
}
tool["ibhagwan/smartyank.nvim"] = {
	lazy = true,
	event = "BufReadPost",
	config = require("tool.smartyank"),
}
tool["michaelb/sniprun"] = {
	lazy = true,
	-- You need to cd to `~/.local/share/nvim/site/lazy/sniprun/` and execute `bash ./install.sh`,
	-- if you encountered error about no executable sniprun found.
	build = "bash ./install.sh",
	cmd = { "SnipRun", "SnipReset", "SnipInfo" },
	keys = keymaps.sniprun(),
	config = require("tool.sniprun"),
}
-- tool["akinsho/toggleterm.nvim"] = {
-- 	lazy = true,
-- 	cmd = {
-- 		"ToggleTerm",
-- 		"ToggleTermSetName",
-- 		"ToggleTermToggleAll",
-- 		"ToggleTermSendVisualLines",
-- 		"ToggleTermSendCurrentLine",
-- 		"ToggleTermSendVisualSelection",
-- 	},
-- 	keys = keymaps.toggleterm(),
-- 	config = require("tool.toggleterm"),
-- }
tool["folke/trouble.nvim"] = {
	lazy = true,
	cmd = { "Trouble", "TroubleToggle", "TroubleRefresh" },
	keys = keymaps.trouble(),
	config = require("tool.trouble"),
}
tool["folke/which-key.nvim"] = {
	lazy = true,
	event = { "CursorHold", "CursorHoldI" },
	config = require("tool.which-key"),
}
tool["nvim-pack/nvim-spectre"] = {
	lazy = true,
	dependencies = { { "nvim-lua/plenary.nvim" } },
	keys = keymaps.spectre(),
	config = require("tool.spectre"),
}
-- general writing
tool["reedes/vim-wordy"] = {
	lazy = true,
	cmd = { "Wordy", "NoWordy", "NextWordy", "PrevWordy" },
}
tool["ron89/thesaurus_query.vim"] = {
	lazy = true,
	cmd = {
		"ThesaurusQueryReplaceCurrentWord",
		"ThesaurusQueryLookupCurrentWord",
		"ThesaurusQueryReplace",
		"ThesaurusQueryReset",
	},
}
tool["kevinhwang91/rnvimr"] = {
	lazy = false,
	-- cmd = { "RnvimrToggle" },
	keys = keymaps.rnvimr(),
	config = require("tool.ranger"),
}
-- kevinhwang91/rnvimr another plugin for ranger
-- kelly-lin/ranger.nvim toggle with command: Ranger

----------------------------------------------------------------------
--                        Telescope Plugins                         --
----------------------------------------------------------------------
tool["nvim-telescope/telescope.nvim"] = {
	lazy = true,
	cmd = "Telescope",
	keys = keymaps.telescope(),
	config = require("tool.telescope"),
	dependencies = {
		{ "nvim-tree/nvim-web-devicons" },
		{ "nvim-lua/plenary.nvim" },
		{ "debugloop/telescope-undo.nvim" },
		{
			"ahmedkhalf/project.nvim",
			event = { "CursorHold", "CursorHoldI" },
			config = require("tool.project"),
		},
		{ "jvgrootveld/telescope-zoxide" },
		{ "nvim-telescope/telescope-frecency.nvim" },
		{ "nvim-telescope/telescope-live-grep-args.nvim" },
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
}

----------------------------------------------------------------------
--                           DAP Plugins                            --
----------------------------------------------------------------------
tool["mfussenegger/nvim-dap"] = {
	lazy = true,
	cmd = {
		"DapSetLogLevel",
		"DapShowLog",
		"DapContinue",
		"DapToggleBreakpoint",
		"DapToggleRepl",
		"DapStepOver",
		"DapStepInto",
		"DapStepOut",
		"DapTerminate",
	},
	keys = keymaps.dap(),
	config = require("tool.dap"),
	dependencies = {
		{
			"rcarriga/nvim-dap-ui",
			config = require("tool.dap.dapui"),
		},
		{ "nvim-neotest/nvim-nio" },
		{ "jay-babu/mason-nvim-dap.nvim" },
		{ "leoluz/nvim-dap-go" },
	},
}
tool["Weissle/persistent-breakpoints.nvim"] = {
	event = "LspAttach",
	config = require("tool.dap.persistent-breakpoints"),
}

-- 	-- Unmanaged plugin (manually installed and updated)
-- 	{ dir = "~/my-prototype-plugin" },

tool["work.nvim"] = {
	lazy = true,
	-- dev = true,
	dir = require("r1v3r.settings").private_plugins_dir .. "/work.nvim",
	cmd = "MyGreet",
	config = function()
		require("work").greet()
	end,
}

return tool

-- mbbill/undotree undotree for select or revert undo operation
