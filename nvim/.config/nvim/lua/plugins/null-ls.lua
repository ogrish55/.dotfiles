return {
	"nvimtools/none-ls.nvim",
	config = function()
		local function is_valid_file(filepath)
			if filepath ~= nil and filepath ~= "" then
				-- Check if the file is ignored by Git
				local res = vim.fn.systemlist({ "git", "check-ignore", filepath })
				if #res > 0 and string.find(res[1], "is in submodule") then
					return true
				end
				if #res > 0 then
					return false
				end

				local valid_paths = {
					"app/code/Wexo",
					"custom/plugins",
					"custom/static-plugins",
				}

				for _, path in ipairs(valid_paths) do
					if filepath:match(".*" .. path .. ".*") then
						return true
					end
				end

				return false
			end
			return false
		end

		local function determineSniffStandard()
			if vim.fn.filereadable("bin/magento") == 1 or vim.fn.filereadable("app/etc/env.php") == 1 then
				return { "--standard=WEXOMagento2" }
			elseif vim.fn.filereadable("bin/console") == 1 or vim.fn.filereadable("config/services.xml") == 1 then
				return { "--standard=WEXOShopware" }
			else
				return { "--standard=PSR2" }
			end
		end

		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				null_ls.builtins.diagnostics.phpcs.with({
					extra_args = determineSniffStandard(),
					runtime_condition = function(params)
						return is_valid_file(params.bufname)
					end,
				}),
				null_ls.builtins.formatting.phpcbf.with({
					extra_args = determineSniffStandard(),
					runtime_condition = function(params)
						return is_valid_file(params.bufname)
					end,
				}),
			},
		})
	end,
}
