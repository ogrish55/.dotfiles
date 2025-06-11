return {
	"L3MON4D3/LuaSnip",
	version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
	build = "make install_jsregexp",
	config = function()
		local luasnip = require("luasnip")

		luasnip.config.set_config({
			ft_func = function()
				local ft = vim.bo.filetype
				local bufname = vim.api.nvim_buf_get_name(0)

				-- If filetype is php and filename ends in .phtml
				if ft == "php" and bufname:match("%.phtml$") then
					return { "php", "html" }
				end

				return ft
			end,
		})

		luasnip.filetype_extend("twig", { "html" })
	end,
}
