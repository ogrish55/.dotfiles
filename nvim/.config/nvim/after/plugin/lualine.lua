require('lualine').setup{
  options = { theme = 'onedark' },
  sections = {
    lualine_a = {
      {
        'filename',
        path = 1,
      }
    }
  }
}
