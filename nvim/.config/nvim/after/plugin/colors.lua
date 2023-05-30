require('onedark').setup {
    style = 'deep'
}

function ColorMyPencils(color)
  -- color = color or "github_dark"
  color = color or "onedark"
  vim.cmd.colorscheme(color)
end


ColorMyPencils()
