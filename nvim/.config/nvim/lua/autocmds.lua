local api = vim.api

-- set buffer name color based on gitignore
api.nvim_create_autocmd({ "BufWinEnter" }, {
	group = api.nvim_create_augroup("personal-winbar-highlight", { clear = true }),
	pattern = "*",
	callback = function()
		local filepath = api.nvim_buf_get_name(0)

		if filepath ~= nil and filepath ~= "" then
			vim.system({ "git", "check-ignore", filepath }, { text = true }, function(obj)
				if obj.code == 0 then
					vim.schedule(function()
						api.nvim_set_hl(0, "WinBar", { fg = "#e3e3e3", bg = "#6a6a6a" })
					end)
				else
					vim.schedule(function()
						api.nvim_set_hl(0, "WinBar", { fg = "#ffffff", bg = "#16161e" })
					end)
				end
			end)
		end
	end,
})

-- set shiftwidt and tabsize for vue
api.nvim_create_autocmd("Filetype", {
	pattern = "vue",
	callback = function()
		vim.opt_local.shiftwidth = 2
		vim.opt_local.tabstop = 2
		vim.opt_local.expandtab = true
	end,
})

-- Enable relative numbers in netrw
vim.api.nvim_create_autocmd("FileType", {
	pattern = "netrw",
	callback = function()
		vim.opt_local.relativenumber = true
	end,
})
