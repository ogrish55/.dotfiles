local opt = vim.opt

opt.autowrite = true

opt.expandtab = true
opt.tabstop = 2

-- Make line numbers default
opt.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
opt.relativenumber = true

--lines to scroll using CTRL+d and CTRL+u
opt.scr = 20

opt.scrolloff = 8

-- Enable mouse mode, can be useful for resizing splits for example!
opt.mouse = "a"

-- opt.wildmode = "longest:full,full"
opt.wildmode = "full"

-- Don't show the mode, since it's already in the status line
opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
	opt.clipboard = "unnamedplus"
end)

-- Enable break indent
opt.breakindent = true

-- Save undo history
opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
opt.ignorecase = true
opt.smartcase = true

-- Keep signcolumn on by default
opt.signcolumn = "yes"

-- Decrease update time
opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
opt.timeoutlen = 300

-- Configure how new splits should be opened
opt.splitright = true
opt.splitbelow = true

opt.wrap = false
opt.ruler = false

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
opt.list = false -- set to true to show below signs on tab, trail etc..
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

opt.smoothscroll = true

opt.smartindent = true -- Insert indents automatically

-- Preview substitutions live, as you type!
opt.inccommand = "split"

-- Show which line your cursor is on
opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
opt.scrolloff = 20
