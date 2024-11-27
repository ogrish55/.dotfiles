require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "php", "typescript", "javascript", "lua", "html", "vim" },
  sync_install = false,
  auto_install = true,
}

--ensure_installed = { "php", "typescript", "javascript", "lua", "html", "vim" },
 -- highlight = {
 --   enable = true,
 --   additional_vim_regex_highlighting = false,
 --   disable = { "sql" }
 -- },
