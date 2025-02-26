return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				null_ls.builtins.diagnostics.phpcs.with({
					extra_args = { "--standard=WEXOMagento2" },
				}),
				null_ls.builtins.formatting.phpcbf.with({
					extra_args = { "--standard=WEXOMagento2" },
				}),
			},
		})
	end,
}
