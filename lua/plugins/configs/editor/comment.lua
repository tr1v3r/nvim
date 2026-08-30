return function()
	require("Comment").setup({
		-- Add a space b/w comment and the line
		padding = true,
		-- Whether the cursor should stay at its position
		sticky = true,
		-- Lines to be ignored while (un)comment
		ignore = "^$",
		-- We defined mappings in `lua/keymap/init.lua` with description so disable them here.
		mappings = {
			-- Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
			basic = false,
			-- Extra mapping; `gco`, `gcO`, `gcA`
			extra = false,
		},
		-- Function to call before (un)comment
		-- pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
		-- Function to call after (un)comment
		post_hook = nil,
	})
end
