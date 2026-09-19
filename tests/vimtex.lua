-- Run with the normal config: nvim --headless "+luafile tests/vimtex.lua"
-- No PDF GUI is opened: a temporary executable captures the viewer arguments.
local function check()
	assert(vim.fn.exists(":VimtexInverseSearch") == 2, "Inverse-search command missing before opening a tex file")
	if not require("r1v3r.global").is_mac then
		print("PASS: VimtexInverseSearch is available (sioyek checks require macOS)")
		return
	end
	assert(vim.g.vimtex_view_method == "sioyek", "Expected sioyek viewer")

	local dir = vim.fn.tempname()
	vim.fn.mkdir(dir, "p")
	local ok, err = pcall(function()
		local tex = dir .. "/reading test.tex"
		local args_file = dir .. "/viewer-args"
		local viewer = dir .. "/capture-viewer"
		vim.fn.writefile({
			"\\documentclass{article}",
			"\\begin{document}",
			"First paragraph.",
			"Second paragraph.",
			"\\end{document}",
		}, tex)
		vim.fn.writefile({ "#!/bin/sh", "printf '%s\\n' \"$@\" > " .. vim.fn.shellescape(args_file) }, viewer)
		assert(vim.uv.fs_chmod(viewer, 448)) -- 0700
		vim.g.vimtex_view_sioyek_exe = viewer
		vim.cmd.edit(vim.fn.fnameescape(tex))
		assert(vim.b.vimtex and vim.b.vimtex.viewer.name == "sioyek", "tex buffer did not initialize sioyek")
		vim.api.nvim_win_set_cursor(0, { 3, 0 })
		vim.cmd("call b:vimtex.viewer._start(" .. vim.fn.string(dir .. "/reading test.pdf") .. ")")
		assert(
			vim.wait(5000, function()
				return vim.fn.filereadable(args_file) == 1 and #vim.fn.readfile(args_file) > 0
			end, 20),
			"Viewer was not invoked"
		)
		local args = vim.fn.readfile(args_file)
		local function option(name)
			for i, value in ipairs(args) do
				if value == name then
					return args[i + 1]
				end
			end
		end
		assert(option("--forward-search-file") == tex, "Forward-search file was not preserved")
		assert(option("--forward-search-line") == "3", "Forward-search line incorrect")
		local inverse = assert(option("--inverse-search"), "Inverse-search callback missing")
		assert(inverse:find("VimtexInverseSearch", 1, true), "Expected native VimTeX callback")

		-- Execute exactly the callback handed to the viewer, replacing its placeholders.
		inverse = inverse:gsub("%%2", "4"):gsub("%%1", function()
			return tex
		end)
		local result
		local child = vim.system({ "/bin/sh", "-c", inverse }, { text = true }, function(value)
			result = value
		end)
		if not vim.wait(20000, function()
			return result ~= nil
		end, 20) then
			child:kill(9)
			child:wait()
			error("Inverse-search callback timed out")
		end
		assert(result.code == 0, result.stderr)
		assert(
			vim.wait(2000, function()
				return vim.api.nvim_win_get_cursor(0)[1] == 4
			end, 20),
			"Inverse search did not reach the original Neovim instance"
		)
		print("PASS: sioyek forward arguments + native inverse-search round trip (path with spaces)")
	end)
	vim.fn.delete(dir, "rf")
	assert(ok, err)
end

local ok, err = pcall(check)
if not ok then
	io.stderr:write(tostring(err) .. "\n")
	vim.cmd("cquit 1")
end
vim.cmd("qa!")
