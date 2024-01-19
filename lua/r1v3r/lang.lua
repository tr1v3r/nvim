-- ============ Language ============

-- Compile function
function CompileRunGcc()
	vim.cmd("w")
	local filetype = vim.bo.filetype
	if filetype == "c" then
		vim.o.splitbelow = true
		vim.cmd("sp")
		vim.cmd("res -5")
		vim.cmd("term gcc % -o %< && time ./%<")
	elseif filetype == "cpp" then
		vim.o.splitbelow = true
		vim.cmd("!g++ -std=c++11 % -Wall -o %<")
		vim.cmd("sp")
		vim.cmd("res -15")
		vim.cmd("term ./%<")
	elseif filetype == "cs" then
		vim.o.splitbelow = true
		vim.cmd("silent! exec '!mcs %'")
		vim.cmd("sp")
		vim.cmd("res -5")
		vim.cmd("term mono %<.exe")
	elseif filetype == "java" then
		vim.o.splitbelow = true
		vim.cmd("sp")
		vim.cmd("res -5")
		vim.cmd("term javac % && time java %<")
	elseif filetype == "sh" then
		vim.cmd("!time bash %")
	elseif filetype == "python" then
		vim.o.splitbelow = true
		vim.cmd("sp")
		vim.cmd("term python3 %")
	elseif filetype == "html" then
		vim.cmd("silent! exec '!'.g:mkdp_browser.' % &'")
	elseif filetype == "markdown" then
		vim.cmd("InstantMarkdownPreview")
	elseif filetype == "tex" then
		vim.cmd("silent! exec 'VimtexStop'")
		vim.cmd("silent! exec 'VimtexCompile'")
	elseif filetype == "dart" then
		vim.cmd([[CocCommand flutter.run -d ".g:flutter_default_device." ".g:flutter_run_args]])
		vim.cmd("silent! exec 'CocCommand flutter.dev.openDevLog'")
	elseif filetype == "javascript" then
		vim.o.splitbelow = true
		vim.cmd("sp")
		vim.cmd('term export DEBUG="INFO,ERROR,WARNING"; node --trace-warnings .')
	elseif filetype == "racket" then
		vim.o.splitbelow = true
		vim.cmd("sp")
		vim.cmd("res -5")
		vim.cmd("term racket %")
	elseif filetype == "go" then
		vim.o.splitbelow = true
		vim.cmd("sp")
		vim.cmd("res -5")
		vim.cmd("term go run .")
	end
end

vim.api.nvim_set_keymap("n", "<LEADER>r", ":lua CompileRunGcc()<CR>", { noremap = true })
