require('plugins')
require('impatient')
require('remap')
require('utils')

local autocmd = vim.api.nvim_create_autocmd

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.autoindent = true

vim.opt.signcolumn = 'yes'

-- Better line visuals
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"
-- vim.cmd[[highlight CursorLineNr guifg=#af00af]] -- Not sure how to add highlighting here

vim.opt.expandtab = true
vim.opt.wrap = false
vim.opt.showmode = true

vim.opt.incsearch = true
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.scrolloff=8
vim.opt.updatetime = 50

-- disable swap files, cause fuck em..
vim.opt.swapfile = false

vim.api.nvim_create_user_command('WQ', 'wq', {})
vim.api.nvim_create_user_command('Wq', 'wq', {})
vim.api.nvim_create_user_command('W', 'w', {})
vim.api.nvim_create_user_command('Qa', 'qa', {})
vim.api.nvim_create_user_command('Q', 'q', {})

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})
