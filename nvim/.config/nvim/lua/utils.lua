local M = {}

M.copyCurrentFilePath = function()
	local path = vim.fn.expand("%")
	vim.fn.setreg("+", path)
	print("PATH COPIED: " .. path)
end

M.getArgs = function(fun)
	local args = {}
	local hook = debug.gethook()

	local argHook = function(...)
		local info = debug.getinfo(3)
		if "pcall" ~= info.name then
			return
		end

		for i = 1, math.huge do
			local name, value = debug.getlocal(2, i)
			if "(*temporary)" == name then
				debug.sethook(hook)
				error("")
				return
			end
			table.insert(args, name)
		end
	end

	debug.sethook(argHook, "c")
	pcall(fun)
	return args
end

M.globalDump = function(...)
	local objects = vim.tbl_map(vim.inspect, { ... })
	print(unpack(objects))
end

return M
