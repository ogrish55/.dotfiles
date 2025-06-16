return {
	"saghen/blink.cmp",
	event = "InsertEnter",
	enabled = true,
	version = "1.*",
	opts_extend = { "sources.default", "sources.compat" },
	dependencies = {
		{
			"L3MON4D3/LuaSnip",
			lazy = true,
			dependencies = {
				{
					"rafamadriz/friendly-snippets",
					config = function()
						require("luasnip.loaders.from_lua").lazy_load({ paths = { "./lua/luasnippets" } })
						require("luasnip.loaders.from_vscode").lazy_load()
						-- require("luasnip.loaders.from_vscode").lazy_load({
						-- 	paths = { vim.fn.stdpath("config") .. "/snippets" },
						-- })
					end,
				},
			},
			opts = { history = true, delete_check_events = "TextChanged" },
		},
		{ "onsails/lspkind.nvim" },
	},
	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		snippets = {
			preset = "luasnip",
		},
		completion = {
			accept = {
				auto_brackets = { enabled = true },
			},
			list = {
				selection = {
					auto_insert = function(ctx)
						return ctx.mode == "cmdline"
					end,
				},
			},
			menu = {
				border = "rounded",
				winblend = 10,
				winhighlight = "Normal:CatppuccinSurface0,FloatBorder:CatppuccinSurface2,Search:None",
				draw = {
					columns = {
						{ "kind_icon", "label", gap = 1 },
						{ "kind" },
					},
					treesitter = { "lsp" },
					components = {
						kind_icon = {
							ellipsis = false,
							text = function(ctx)
								local icon = ctx.kind_icon
								if vim.tbl_contains({ "Path" }, ctx.source_name) then
									local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
									if dev_icon then
										icon = dev_icon
									end
								else
									icon = require("lspkind").symbolic(ctx.kind, {
										mode = "symbol",
									})
								end

								return icon .. ctx.icon_gap
							end,
							highlight = function(ctx)
								local hl = "BlinkCmpKind" .. ctx.kind
								if vim.tbl_contains({ "Path" }, ctx.source_name) then
									local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
									if dev_icon then
										hl = dev_hl
									end
								end
								return hl
							end,
						},
					},
				},
			},
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 50,
				window = {
					border = "rounded",
					winblend = 10,
					winhighlight = "Normal:CatppuccinSurface0,FloatBorder:CatppuccinSurface2,Search:None",
				},
			},
		},
		signature = {
			enabled = true,
			window = {
				border = "rounded",
				winblend = 10,
				winhighlight = "Normal:CatppuccinSurface0,FloatBorder:CatppuccinSurface2,Search:None",
			},
		},
		fuzzy = {
			sorts = {
				-- function(a, b)
				-- 	if a.exact and a.label == "log" and a.source_name == "snippets" then
				-- 		return true
				-- 	end
				-- 	return nil
				-- end,
				"exact",
				"score",
				"sort_text",
			},
			implementation = "rust",
			use_proximity = true,
			use_frecency = true,
		},
		cmdline = {
			enabled = true,
			completion = {
				menu = {
					auto_show = true,
				},
			},
			keymap = {
				preset = "super-tab",
				["<C-y>"] = { "accept", "fallback" },
				["<C-k>"] = { "select_prev", "fallback" },
				["<C-j>"] = { "select_next", "fallback" },
			},
		},
		keymap = {
			preset = "super-tab",
			["<C-y>"] = { "accept", "fallback" },
			["<C-k>"] = { "select_prev", "fallback" },
			["<C-j>"] = { "select_next", "fallback" },
			["<Cr>"] = { "accept", "fallback" },
		},
		sources = {
			default = { "lsp", "path", "snippets", "buffer", "markdown" },
			providers = {
				snippets = {
					name = "snippets",
					enabled = true,
					module = "blink.cmp.sources.snippets",
				},
				markdown = {
					name = "RenderMarkdown",
					enabled = true,
					module = "render-markdown.integ.blink",
					fallbacks = { "lsp" },
				},
			},
		},
	},
}
