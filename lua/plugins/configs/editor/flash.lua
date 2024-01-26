return function()
	vim.api.nvim_set_hl(
		0,
		"FlashLabel",
		{ underline = true, bold = true, fg = "Orange", bg = "NONE", ctermfg = "Red", ctermbg = "NONE" }
	)

	-- default config: https://github.com/folke/flash.nvim/tree/main#%EF%B8%8F-configuration
	require("flash").setup({
		-- labels = "asdfghjklqwertyuiopzxcvbnm",
		labels = "tsrneidhaogjplfuwyqvbkcmxz", -- for colemak keymaps
		label = {
			-- allow uppercase labels
			uppercase = false,
			-- add a label for the first match in the current window.
			-- you can always jump to the first match with `<CR>`
			current = true,
			-- for the current window, label targets closer to the cursor first
			distance = true,
			-- position of the label extmark
			style = "overlay", ---@type "eol" | "overlay" | "right_align" | "inline"
		},
		jump = {
			-- automatically jump when there is only one match
			autojump = true,
		},
		modes = {
			search = { enabled = false },
			-- options used when flash is activated through
			-- `f`, `F`, `t`, `T`, `;` and `,` motions
			char = {
				enabled = true,
				-- hide after jump when not using jump labels
				autohide = false,
				-- show jump labels
				jump_labels = true,
				-- set to `false` to use the current line only
				multi_line = true,
				-- When using jump labels, don't use these keys
				-- This allows using those keys directly after the motion
				label = { exclude = "neiukardc" },
			},
		},
	})

	local function TwoCharJump(opts)
		local Flash = require("flash")

		---@param opts Flash.Format
		local function format(opts)
			-- always show first and second label
			return {
				{ opts.match.label1, "FlashMatch" },
				{ opts.match.label2, "FlashLabel" },
			}
		end

		Flash.jump({
			search = { mode = "search" },
			label = { after = false, before = { 0, 0 }, uppercase = false, format = format },
			-- eg: "^", [[\<]]
			pattern = opts.args,
			action = function(match, state)
				state:hide()
				Flash.jump({
					search = { max_length = 0 },
					highlight = { matches = false },
					label = { format = format },
					matcher = function(win)
						-- limit matches to the current label
						return vim.tbl_filter(function(m)
							return m.label == match.label and m.win == win
						end, state.results)
					end,
					labeler = function(matches)
						for _, m in ipairs(matches) do
							m.label = m.label2 -- use the second label
						end
					end,
				})
			end,
			labeler = function(matches, state)
				local labels = state:labels()
				for m, match in ipairs(matches) do
					match.label1 = labels[math.floor((m - 1) / #labels) + 1]
					match.label2 = labels[(m - 1) % #labels + 1]
					match.label = match.label1
				end
			end,
		})
	end
	vim.api.nvim_create_user_command("TwoCharJump", TwoCharJump, { nargs = 1, desc = "2 char to anywhere" })

	-- jump to line:
	-- require("flash").jump({ search = { mode = "search", max_length = 0 }, label = { after = { 0, 0 } }, pattern = "^" })
	-- Initialize flash with the word under the cursor
	-- require("flash").jump({ pattern = vim.fn.expand("<cword>") })

	require("flash").toggle()
end
