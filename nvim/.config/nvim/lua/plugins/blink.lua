return {
	"saghen/blink.cmp",
	event = "InsertEnter",
	enabled = true,
	version = "*",
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
				draw = { treesitter = { "lsp" } },
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
			enabled = false,
			window = {
				border = "rounded",
				winblend = 10,
				winhighlight = "Normal:CatppuccinSurface0,FloatBorder:CatppuccinSurface2,Search:None",
			},
		},
		fuzzy = {
			-- max_typos = function(keyword)
			-- 	return 0
			-- end,
			use_proximity = true,
			use_frecency = true,
			prebuilt_binaries = {
				download = true,
			},
		},
		cmdline = {
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
			default = { "lsp", "path", "snippets", "buffer" },
			providers = {
				snippets = {
					name = "snippets",
					enabled = true,
					module = "blink.cmp.sources.snippets",
				},
			},
		},
	},
}
