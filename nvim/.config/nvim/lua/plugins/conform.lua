return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>fb",
			function()
				require("conform").format({ async = true, lsp_format = "fallback" })
			end,
			mode = "",
			desc = "[F]ormat [B]uffer",
		},
	},
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			twig = { "ludtwig" },
		},
		formatters = {
			ludtwig = {
				command = "ludtwig",
				args = { "--fix", "$FILENAME" },
				stdin = false,
			},
		},
		notify_on_error = true,
		format_on_save = function(bufnr)
			-- check if file is in gitignore
			-- if it's ignored, don't format.
			--
			--
			-- Disable "format_on_save lsp_fallback" for languages that don't
			-- have a well standardized coding style. You can add additional
			-- languages here or re-enable it for the disabled ones.
			local disable_filetypes = {}

			local lsp_format_opt
			if disable_filetypes[vim.bo[bufnr].filetype] then
				lsp_format_opt = "never"
			else
				lsp_format_opt = "fallback"
			end
			return {
				timeout_ms = 500,
				lsp_format = lsp_format_opt,
			}
		end,
	},
}
