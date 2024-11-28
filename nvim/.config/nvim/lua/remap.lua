vim.g.mapleader = " "
vim.keymap.set("n", "J", "mzJ`z", { desc = 'dont move cursor when merging lines'})

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = 'center on going up'})
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = 'center on going down'})
vim.keymap.set("n", "n", "nzzzv", { desc = 'center on next search'})
vim.keymap.set("n", "N", "Nzzzv", { desc = 'center on next search'})

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = 'Move visually selected down'})
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = 'Move visually selected up'})
vim.keymap.set("v", "<leader>p", "_dP", { desc = 'paste without yanking'})
vim.keymap.set("n", "<leader>y", "\"*y", { desc = 'yank to clipboard'})
vim.keymap.set("v", "<leader>y", "\"*y", { desc = 'yank to clipboard'})
vim.keymap.set("n", "<leader>Y", "\"*Y", { desc = 'yank to clipboard'})

vim.api.nvim_set_keymap("n", "<space>en", ":lua require('utils').edit_neovim()<CR>", { noremap = true , desc = 'quickly edit neovim config files'})

-- vim.keymap.set("n", "<leader>fd", vim.cmd.Ex, { desc = 'file explorer'})
vim.keymap.set("n", "<leader>dd", ":lua require('nvim-tree.api').tree.toggle()<CR>", { desc = 'file explorer'})


vim.keymap.set("n", "<leader>Y", "\"*Y", { desc = 'yank to clipboard'})
