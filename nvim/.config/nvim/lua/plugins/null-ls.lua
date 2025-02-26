return {
	"nvimtools/none-ls.nvim",
	config = function()
		local function is_not_gitignored(filepath)
			if filepath ~= nil and filepath ~= "" then
				local res = vim.fn.systemlist({ "git", "check-ignore", filepath })
				return #res == 0
			end
			return false
		end

		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				null_ls.builtins.diagnostics.phpcs.with({
					-- extra_args could probably be modified to use a different standard based on utils function.
					-- using utils function to determine if current project is a shopware or magento or neither
					extra_args = { "--standard=WEXOMagento2" },
					runtime_condition = function(params)
						-- we don't want to see diagnostics on gitignored files
						return is_not_gitignored(params.bufname)
					end,
				}),
				null_ls.builtins.formatting.phpcbf.with({
					extra_args = { "--standard=WEXOMagento2" },
					runtime_condition = function(params)
						-- we don't want to run phpcbf on gitignored files
						return is_not_gitignored(params.bufname)
					end,
				}),
			},
		})
	end,
}
