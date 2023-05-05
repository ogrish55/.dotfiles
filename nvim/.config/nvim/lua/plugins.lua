local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'airblade/vim-rooter'
  use 'nvim-lualine/lualine.nvim'

  -- show inline diagnostic erros
  use { "folke/trouble.nvim", requires = "kyazdani42/nvim-web-devicons", }

  use { "lewis6991/gitsigns.nvim", }

  -- undo tree (open using <leader> u)
  use 'mbbill/undotree'

  -- Impatient for caching
  use 'lewis6991/impatient.nvim'

  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }

  -- throws an error when used at the moment - try again later
  -- https://github.com/molecule-man/telescope-menufacture

  use {
    "molecule-man/telescope-menufacture",
    config = function() require"telescope".load_extension("menufacture") end
  }

  -- colorschemes
  use { 'rose-pine/neovim', as = 'rose-pine' }
  use { 'navarasu/onedark.nvim' }

  use {
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 500
      require("which-key").setup {}
    end
  }

  -- Telescope
  use { 'nvim-telescope/telescope.nvim', tag = '0.1.0', requires = { {'nvim-lua/plenary.nvim'} }}

  -- Plugin for "frequently used files" <leader>ee
  use {
    "nvim-telescope/telescope-frecency.nvim",
    config = function() require"telescope".load_extension("frecency") end,
    requires = {"kkharji/sqlite.lua"}
  }


  -- Use fzf-native to improve telescope performance
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

  -- Treesitter for pretty colorz
  use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})

  -- Not sure what smart-history is.. Need to look into it.
  use('nvim-telescope/telescope-smart-history.nvim')

  -- LSP
  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    requires = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},             -- Required
      {                                      -- Optional
      'williamboman/mason.nvim',
      run = function()
        pcall(vim.cmd, 'MasonUpdate')
      end,
    },
    {'williamboman/mason-lspconfig.nvim'}, -- Optional

    -- Autocompletion
    {'hrsh7th/nvim-cmp'},     -- Required
    {'hrsh7th/cmp-nvim-lsp'}, -- Required
    {'L3MON4D3/LuaSnip'},     -- Required
  }
}

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
