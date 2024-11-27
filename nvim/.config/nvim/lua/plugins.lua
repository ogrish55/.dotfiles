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

  -- nvim-tree
  use 'nvim-tree/nvim-tree.lua'

  -- auto pairs for ({[]}) ..etc
  use 'jiangmiao/auto-pairs'

  -- Impatient for caching
  use 'lewis6991/impatient.nvim'

  -- comment plugin. normal mode: gcc
  -- visual mode: gc
  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }

  -- colorschemes
  use { 'rose-pine/neovim', as = 'rose-pine' }
  use { 'navarasu/onedark.nvim' }
  use { 'projekt0n/github-nvim-theme' }

  -- Telescope
  use { 'nvim-telescope/telescope.nvim', tag = '0.1.0', requires = { {'nvim-lua/plenary.nvim'} }}

  -- Use fzf-native to improve telescope performance
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

  -- Treesitter for pretty colorz
  use { 'nvim-treesitter/nvim-treesitter',
  commit = '668de0951a36ef17016074f1120b6aacbe6c4515',
  run = ':TSUpdate' }

  -- LSP
  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    requires = {
      -- LSP Support
    {'neovim/nvim-lspconfig'},             -- Required
    {'williamboman/mason.nvim',
      run = function()
        pcall(vim.cmd, 'MasonUpdate')
      end,
    },
    {'williamboman/mason-lspconfig.nvim'}, -- Optional
    --
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
