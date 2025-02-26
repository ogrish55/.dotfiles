return {
	"danymat/neogen",
	dependencies = "nvim-treesitter/nvim-treesitter",
	opts = {
		enabled = true,
		languages = {
			php = {
				template = {
					annotation_convention = "phpdoc",
				},
			},
		},
	},
}
