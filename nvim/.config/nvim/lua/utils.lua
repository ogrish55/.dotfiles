local M = {}

M.copyCurrentFilePath = function()
	local path = vim.fn.expand("%")
	vim.fn.setreg("+", path)
	print("PATH COPIED: " .. path)
end

M.deleteVendorBuffers = function()
	-- using the dict you can return only buffers that have been modified.. Smart - like jetbrains
	-- this doesn't work the way it's expected when using fzf-lua file browser.
	local buffers = vim.fn.getbufinfo()
	for _, buf in ipairs(buffers) do
		local res = vim.fn.systemlist({ "git", "check-ignore", buf.name })
		if #res ~= 0 then
			vim.api.nvim_buf_delete(buf.bufnr, { force = false })
		else
		end
	end
end

M.deleteAllBuffers = function()
	local current = vim.fn.bufnr("%")
	local previous = vim.fn.bufnr("#")

	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buflisted then
			if buf ~= current and buf ~= previous and vim.bo[buf].buftype ~= "terminal" then
				vim.cmd("bdelete " .. buf)
			end
		end
	end
end

M.deleteOldBuffers = function()
	-- loop through the buffers
	-- if lastused is older than 24 hours?
	-- delete it
	local buffers = vim.fn.getbufinfo()
	for _, buf in ipairs(buffers) do
		-- calculate 1 day old..
		print(vim.fn.localtime())
		print(vim.inspect(buf.lastused))
	end
end

vim.api.nvim_create_user_command("DeleteVendorBuffers", M.deleteVendorBuffers, { nargs = 0 })
vim.api.nvim_create_user_command("DeleteAllBuffers", M.deleteAllBuffers, { nargs = 0 })
vim.api.nvim_create_user_command("DeleteOldBuffers", M.deleteOldBuffers, { nargs = 0 })

return M
