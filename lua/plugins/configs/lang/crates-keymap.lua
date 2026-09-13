local crates = require("crates")

local function map(mode, lhs, rhs, desc)
	vim.keymap.set(mode, lhs, rhs, {
		buffer = true,
		silent = true,
		desc = "crates: " .. desc,
	})
end

map("n", "<leader>Ct", crates.toggle, "Toggle virtual text")
map("n", "<leader>Cr", crates.reload, "Reload crate data")
map("n", "<leader>Cv", crates.show_versions_popup, "Show versions")
map("n", "<leader>Cf", crates.show_features_popup, "Show features")
map("n", "<leader>Cd", crates.show_dependencies_popup, "Show dependencies")
map("n", "<leader>Cu", crates.update_crate, "Update crate")
map("v", "<leader>Cu", crates.update_crates, "Update selected crates")
map("n", "<leader>Ca", crates.update_all_crates, "Update all crates")
map("n", "<leader>CU", crates.upgrade_crate, "Upgrade crate")
map("v", "<leader>CU", crates.upgrade_crates, "Upgrade selected crates")
map("n", "<leader>CA", crates.upgrade_all_crates, "Upgrade all crates")
map("n", "<leader>Cx", crates.expand_plain_crate_to_inline_table, "Expand crate declaration")
map("n", "<leader>CX", crates.extract_crate_into_table, "Extract crate declaration")
map("n", "<leader>Ch", crates.open_homepage, "Open homepage")
map("n", "<leader>CR", crates.open_repository, "Open repository")
map("n", "<leader>CD", crates.open_documentation, "Open documentation")
map("n", "<leader>CC", crates.open_crates_io, "Open crates.io")
map("n", "<leader>CL", crates.open_lib_rs, "Open lib.rs")
