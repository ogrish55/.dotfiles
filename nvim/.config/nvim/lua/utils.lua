local M = {}

M.copyCurrentFilePath = function()
	local path = vim.fn.expand("%")
	vim.fn.setreg("+", path)
	print("PATH COPIED: " .. path)
end

return M
