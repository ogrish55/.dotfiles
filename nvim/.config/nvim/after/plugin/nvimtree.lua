require('nvim-tree').setup {
  sort_by = "case_sensitive",
  view = {
    width = 40,
    relativenumber = true
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = false,
    git_ignored = false
  },
}
