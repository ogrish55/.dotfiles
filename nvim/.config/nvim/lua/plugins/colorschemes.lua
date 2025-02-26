return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		init = function()
			vim.cmd.colorscheme("catppuccin-mocha")
			vim.cmd.hi("Comment gui=none")
		end,
	},
	{
		"folke/tokyonight.nvim",
		priority = 1000, -- Make sure to load this before all the other start plugins.
		-- init = function()
		-- 	vim.cmd.colorscheme("tokyonight-night")
		-- 	vim.cmd.hi("Comment gui=none")
		-- end,
	},
}
