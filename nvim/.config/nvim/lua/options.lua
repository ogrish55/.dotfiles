local opt = vim.opt

opt.autowrite = true
opt.expandtab = true
opt.tabstop = 2
opt.number = true
opt.relativenumber = true
opt.winbar = "%=%f%="
opt.scroll = 20
opt.mouse = "a"
opt.wildmode = "full"
opt.showmode = false
vim.schedule(function()
	opt.clipboard = "unnamedplus"
end)
opt.breakindent = true
opt.undofile = true
opt.ignorecase = true
opt.smartcase = true
opt.signcolumn = "yes"
opt.updatetime = 250
opt.timeoutlen = 300
opt.splitright = true
opt.splitbelow = true
opt.wrap = false
opt.ruler = false
opt.list = false -- set to true to show below signs on tab, trail etc..
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
opt.smoothscroll = true
opt.smartindent = true -- Insert indents automatically
opt.inccommand = "split"
opt.cursorline = true
opt.scrolloff = 20
opt.updatetime = 50
