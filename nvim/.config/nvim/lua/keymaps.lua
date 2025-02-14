local utils = require("utils")

-- CUSTOM UTILS KEYMAPS
-- copying current file path like in phpstorm
vim.keymap.set("n", "<leader>cf", utils.copyCurrentFilePath)

-- GIT
vim.keymap.set("n", "<leader>gb", function()
	require("gitsigns").blame()
end, { desc = "[G]it [B]lame" })

--
-- Diagnostic keymaps
-- vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
--
-- Quickfix keymaps
-- vim.keymap.set("n", "<C-n>", "<cmd>cnext<CR>")
-- vim.keymap.set("n", "<C-p>", "<cmd>cprev<CR>")

-- Changelist keymaps
vim.keymap.set("n", "<C-p>", "g;", { desc = "Go to previous change" })
vim.keymap.set("n", "<C-n>", "g,", { desc = "Go to next change" })

--------------FZFLUA KEYMAPS--------------
vim.keymap.set("n", "<leader>r", function()
	require("fzf-lua").live_grep()
end, { desc = "[S]earch [H]elp" })

vim.keymap.set("n", "<leader>e", function()
	require("fzf-lua").buffers()
end, { desc = "[ ] Find existing buffers" })

vim.keymap.set("n", "<leader>w", function()
	require("fzf-lua").files()
end)

vim.keymap.set("n", "<leader>q", function()
	require("fzf-lua").files()
end)

vim.keymap.set("n", "<leader>o", function()
	require("fzf-lua").oldfiles()
end)

vim.keymap.set("n", "<leader>x", function()
	require("fzf-lua").lsp_document_symbols()
end)

vim.keymap.set("n", "<leader>sh", function()
	require("fzf-lua").helptags()
end, { desc = "[S]earch [H]elp" })

vim.keymap.set("n", "<leader>sk", function()
	require("fzf-lua").keymaps()
end, { desc = "[S]earch [K]eymaps" })

-- Harpoon
local harpoon = require("harpoon")
vim.keymap.set("n", "<leader>a", function()
	harpoon:list():add()
end)
vim.keymap.set("n", "<leader>l", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end)

vim.keymap.set("n", "<C-h>", function()
	harpoon:list():select(1)
end)
vim.keymap.set("n", "<C-j>", function()
	harpoon:list():select(2)
end)
vim.keymap.set("n", "<C-k>", function()
	harpoon:list():select(3)
end)
vim.keymap.set("n", "<C-l>", function()
	harpoon:list():select(4)
end)
vim.keymap.set("n", "<C-æ>", function()
	harpoon:list():select(5)
end)

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "n", "nzzzv")

vim.keymap.set("n", "-", "<C-6>")

return {}
