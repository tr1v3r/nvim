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
tools["folke/snacks.nvim"] = {
	priority = 1000,
	lazy = false,
	keys = keymaps.snacks(),
	opts = require("tools.snacks").opts,
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
-- tools["kdheepak/lazygit.nvim"] = { use snacks.lazygit instead
-- 	lazy = true,
-- 	cmd = "LazyGit",
-- 	keys = keymaps.lazygit(),
-- 	config = require("tools.lazygit"),
-- 	-- optional for floating window border decoration
-- 	dependencies = { "nvim-lua/plenary.nvim" },
-- }
tools["ibhagwan/smartyank.nvim"] = {
	lazy = true,
	event = "BufReadPost",
	config = require("tools.smartyank"),
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
	cmd = "Trouble",
	keys = keymaps.trouble(),
	config = require("tools.trouble"),
}
tools["folke/which-key.nvim"] = {
	lazy = true,
	event = "VeryLazy",
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
tools["kawre/leetcode.nvim"] = {
	cmd = "Leet",
	keys = keymaps.leetcode(),
	opts = require("tools.leetcode").opts,
	config = require("tools.leetcode").config,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
	},
}
-- tool["kevinhwang91/rnvimr"] = {
-- 	lazy = false,
-- 	-- cmd = { "RnvimrToggle" },
-- 	keys = keymaps.rnvimr(),
-- 	config = require("tools.ranger"),
-- }
-- kevinhwang91/rnvimr another plugin for ranger
-- kelly-lin/ranger.nvim toggle with command: Ranger

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
			event = { "BufReadPost", "BufNewFile" },
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
		{
			"Weissle/persistent-breakpoints.nvim",
			config = require("tools.dap.persistent-breakpoints"),
		},
		-- mason is kept ONLY for DAP adapter management; LSP servers and
		-- formatters moved to system packages (brew/go/cargo).
		{
			"mason-org/mason.nvim",
			config = require("tools.mason"),
		},
		{ "jay-babu/mason-nvim-dap.nvim" },
		{ "leoluz/nvim-dap-go" },
	},
}
----------------------------------------------------------------------
--                        AI Assistant Plugins                      --
----------------------------------------------------------------------
tools["NickvanDyke/opencode.nvim"] = {
	lazy = true,
	cmd = "OpencodePrompt",
	keys = keymaps.opencode(),
	config = require("tools.opencode"),
	dependencies = {
		{ "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
	},
}

-- 	-- Unmanaged plugin (manually installed and updated)
-- 	{ dir = "~/my-prototype-plugin" },

----------------------------------------------------------------------
--                        DIY Plugins                      --
----------------------------------------------------------------------
tools["work.nvim"] = {
	enabled = false,
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
