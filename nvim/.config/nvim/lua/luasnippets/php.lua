local luasnip = require("luasnip")
local s = luasnip.snippet
local t = luasnip.text_node
local i = luasnip.insert_node

local file_put_contents = {
	s("fpc", {
		t('file_put_contents("/var/www/html/debuglogging.log", date("Y-m-d H:i:s") . "\\t:\\t" . "'),
		i(1),
		t('" . "\\n", FILE_APPEND);'),
	}),
}

local constructor = {
	s("__constructor", {
		t({
			"public function __construct(",
			"    ",
		}),
		i(1),
		t({
			"",
			") {",
			"}",
		}),
	}),
}

luasnip.add_snippets("php", file_put_contents)
luasnip.add_snippets("php", constructor)
