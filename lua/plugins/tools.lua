local tools = {}
local keymaps = require("r1v3r.keymaps")

tools["dstein64/vim-startuptime"] = {
	-- lazy-load on a command
	cmd = "StartupTime",
	-- init is called during startup. Configuration for vim plugins typically should be set in an init function
	init = function()
		vim.g.startuptime_tries = 10
	end,
}
tools["nvim-tree/nvim-tree.lua"] = {
	lazy = true,
	cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeFindFile", "NvimTreeFindFileToggle", "NvimTreeRefresh" },
	keys = keymaps.nvim_tree(),
	config = require("tools.nvim-tree"),
}
tools["tpope/vim-fugitive"] = {
	lazy = true,
	keys = keymaps.vim_fugitive(),
	cmd = { "Git", "G" },
}
tools["gelguy/wilder.nvim"] = {
	lazy = true,
	event = "CmdlineEnter",
	config = require("tools.wilder"),
	dependencies = { "romgrk/fzy-lua-native" },
}
tools["kdheepak/lazygit.nvim"] = {
	lazy = true,
	cmd = "LazyGit",
	keys = keymaps.lazygit(),
	config = require("tools.lazygit"),
	-- optional for floating window border decoration
	dependencies = { "nvim-lua/plenary.nvim" },
}
tools["ibhagwan/smartyank.nvim"] = {
	lazy = true,
	event = "BufReadPost",
	config = require("tools.smartyank"),
}
tools["michaelb/sniprun"] = {
	lazy = true,
	-- You need to cd to `~/.local/share/nvim/site/lazy/sniprun/` and execute `bash ./install.sh`,
	-- if you encountered error about no executable sniprun found.
	build = "bash ./install.sh",
	cmd = { "SnipRun", "SnipReset", "SnipInfo" },
	keys = keymaps.sniprun(),
	config = require("tools.sniprun"),
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
-- 	config = require("tools.toggleterm"),
-- }
tools["folke/trouble.nvim"] = {
	lazy = true,
	cmd = { "Trouble", "TroubleToggle", "TroubleRefresh" },
	keys = keymaps.trouble(),
	config = require("tools.trouble"),
}
tools["folke/which-key.nvim"] = {
	lazy = true,
	event = { "CursorHold", "CursorHoldI" },
	config = require("tools.which-key"),
}
tools["nvim-pack/nvim-spectre"] = {
	lazy = true,
	dependencies = { { "nvim-lua/plenary.nvim" } },
	keys = keymaps.spectre(),
	config = require("tools.spectre"),
}
-- general writing
tools["reedes/vim-wordy"] = {
	lazy = true,
	cmd = { "Wordy", "NoWordy", "NextWordy", "PrevWordy" },
}
tools["ron89/thesaurus_query.vim"] = {
	lazy = true,
	cmd = {
		"ThesaurusQueryReplaceCurrentWord",
		"ThesaurusQueryLookupCurrentWord",
		"ThesaurusQueryReplace",
		"ThesaurusQueryReset",
	},
}
tools["mikavilpas/yazi.nvim"] = {
	lazy = true,
	event = "VeryLazy",
	keys = keymaps.yazi(),
	opts = require("tools.yazi").opts,
	init = require("tools.yazi").init,
}
-- tool["kevinhwang91/rnvimr"] = {
-- 	lazy = false,
-- 	-- cmd = { "RnvimrToggle" },
-- 	keys = keymaps.rnvimr(),
-- 	config = require("tools.ranger"),
-- }
-- kevinhwang91/rnvimr another plugin for ranger
-- kelly-lin/ranger.nvim toggle with command: Ranger

tools["folke/snacks.nvim"] = {
	priority = 1000,
	lazy = false,
	keys = keymaps.snacks(),
	opts = require("tools.snacks").opts,
}

----------------------------------------------------------------------
--                        Telescope Plugins                         --
----------------------------------------------------------------------
tools["nvim-telescope/telescope.nvim"] = {
	lazy = true,
	cmd = "Telescope",
	keys = keymaps.telescope(),
	config = require("tools.telescope"),
	dependencies = {
		{ "nvim-tree/nvim-web-devicons" },
		{ "nvim-lua/plenary.nvim" },
		{ "debugloop/telescope-undo.nvim" },
		{
			"ahmedkhalf/project.nvim",
			event = { "CursorHold", "CursorHoldI" },
			config = require("tools.project"),
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
tools["mfussenegger/nvim-dap"] = {
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
	config = require("tools.dap"),
	dependencies = {
		{
			"rcarriga/nvim-dap-ui",
			config = require("tools.dap.dapui"),
		},
		{ "nvim-neotest/nvim-nio" },
		{ "jay-babu/mason-nvim-dap.nvim" },
		{ "leoluz/nvim-dap-go" },
	},
}
tools["Weissle/persistent-breakpoints.nvim"] = {
	event = "LspAttach",
	config = require("tools.dap.persistent-breakpoints"),
}

-- 	-- Unmanaged plugin (manually installed and updated)
-- 	{ dir = "~/my-prototype-plugin" },

tools["work.nvim"] = {
	lazy = true,
	-- dev = true,
	dir = require("r1v3r.settings").private_plugins_dir .. "/work.nvim",
	cmd = "MyGreet",
	config = function()
		require("work").greet()
	end,
}

return tools

-- mbbill/undotree undotree for select or revert undo operation
