local luasnip = require("luasnip")
local s = luasnip.snippet
local t = luasnip.text_node
local i = luasnip.insert_node

local FILETYPES = { "typescript", "vue", "javascript" }

-- local consoleLog = {
-- 	s("log", {
-- 		t("console.log("),
-- 		i(1),
-- 		t(")"),
-- 	}),
-- }

local consoleDir = {
	s("dir", {
		t("console.dir("),
		i(1),
		t(", {depth: null})"),
	}),
}

local consoleTrace = {
	s("trace", {
		t("console.trace()"),
	}),
}

for _, ft in pairs(FILETYPES) do
	-- luasnip.add_snippets(ft, consoleLog)
	luasnip.add_snippets(ft, consoleDir)
	luasnip.add_snippets(ft, consoleTrace)
end
