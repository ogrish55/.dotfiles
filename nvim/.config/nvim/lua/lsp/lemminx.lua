local M = {}

function M.build_config()
	local util = require("lspconfig.util")

	local function magento_root(fname)
		local git = util.find_git_ancestor(fname)
		if git then
			return git
		end

		local cwd = vim.loop.cwd()
		if
			cwd
			and not cwd:match(util.path.sep .. "vendor" .. util.path.sep)
			and util.path.exists(util.path.join(cwd, "composer.json"))
		then
			return cwd
		end

		local nearest = util.root_pattern("composer.json")(fname)
		if nearest and nearest:match(util.path.sep .. "vendor" .. util.path.sep) then
			local dir = util.path.dirname(nearest)
			while dir and dir:match(util.path.sep .. "vendor" .. util.path.sep) do
				dir = util.path.dirname(dir)
			end
			local above_vendor = util.root_pattern("composer.json")(dir) or dir
			return above_vendor
		end

		return nearest or util.path.dirname(fname)
	end

	-- Full lemminx server config (Magento-aware schemas)
	return {
		root_dir = magento_root,

		on_new_config = function(new_config, root_dir)
			local function uri(...)
				return vim.uri_from_fname(util.path.join(root_dir, ...))
			end

			new_config.settings = new_config.settings or {}
			new_config.settings.xml = new_config.settings.xml or {}

			new_config.settings.xml.fileAssociations = {
				-- DI (global + area-scoped)
				{
					pattern = "**/etc/di.xml",
					systemId = uri("vendor", "magento", "framework", "ObjectManager", "etc", "config.xsd"),
				},
				{
					pattern = "**/etc/**/di.xml",
					systemId = uri("vendor", "magento", "framework", "ObjectManager", "etc", "config.xsd"),
				},

				-- Module declaration
				{
					pattern = "**/etc/module.xml",
					systemId = uri("vendor", "magento", "framework", "Module", "etc", "module.xsd"),
				},

				-- Events (global + area)
				{
					pattern = "**/etc/events.xml",
					systemId = uri("vendor", "magento", "framework", "Event", "etc", "events.xsd"),
				},
				{
					pattern = "**/etc/**/events.xml",
					systemId = uri("vendor", "magento", "framework", "Event", "etc", "events.xsd"),
				},

				-- Routes (area-scoped)
				{
					pattern = "**/etc/**/routes.xml",
					systemId = uri("vendor", "magento", "framework", "App", "etc", "routes.xsd"),
				},

				-- ACL
				{
					pattern = "**/etc/acl.xml",
					systemId = uri("vendor", "magento", "framework", "Acl", "etc", "acl.xsd"),
				},

				-- Web API
				{
					pattern = "**/etc/webapi.xml",
					systemId = uri("vendor", "magento", "module-webapi", "etc", "webapi.xsd"),
				},

				-- Layouts & page layouts
				{
					pattern = "**/view/**/layout/*.xml",
					systemId = uri("vendor", "magento", "framework", "View", "Layout", "etc", "layout_generic.xsd"),
				},
				{
					pattern = "**/view/**/page_layout/*.xml",
					systemId = uri("vendor", "magento", "framework", "View", "PageLayout", "etc", "page_layout.xsd"),
				},
			}

			-- If you later add a catalog, enable it here:
			-- new_config.settings.xml.catalogs = { util.path.join(root_dir, ".lemminx", "catalog.xml") }
		end,
	}
end

return M
