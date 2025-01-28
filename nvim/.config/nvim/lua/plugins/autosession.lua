return {
	"rmagatti/auto-session",
	lazy = false,

	---enables autocomplete for opts
	---@module "auto-session"
	---@type AutoSession.Config
	opts = {
		suppressed_dirs = { "~/", "~/Projects/daarbakgroup/" },
		allowed_dirs = {
			"~/Projects/*",
			"~/.dotfiles/",
			"~/Projects/daarbakgroup/strapi/",
			"~/Projects/daarbakgroup/frontend/roso-frontend/",
			"~/Projects/daarbakgroup/middleware/",
			"~/Projects/daarbakgroup/backend/*",
		},
		-- log_level = 'debug',
	},
}
