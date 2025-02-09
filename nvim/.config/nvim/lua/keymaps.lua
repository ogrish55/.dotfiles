local builtin = require("telescope.builtin")
local utils = require("utils")
local themes = require("telescope.themes")

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

vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
vim.keymap.set("n", "<leader>sc", builtin.resume, { desc = "[S]earch [C]ontinue" })

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

-- Slightly advanced example of overriding default behavior and theme
vim.keymap.set("n", "<leader>/", function()
	-- You can pass additional configuration to Telescope to change the theme, layout, etc.
	builtin.current_buffer_fuzzy_find(themes.get_dropdown({
		winblend = 10,
		previewer = false,
	}))
end, { desc = "[/] Fuzzily search in current buffer" })

-- It's also possible to pass additional configuration options.
--  See `:help telescope.builtin.live_grep()` for information about particular keys
vim.keymap.set("n", "<leader>s/", function()
	builtin.live_grep({
		grep_open_files = true,
		prompt_title = "Live Grep in Open Files",
	})
end, { desc = "[S]earch [/] in Open Files" })
vim.keymap.set("n", "<leader>sn", function()
	builtin.find_files({ cwd = vim.fn.stdpath("config") })
end, { desc = "[S]earch [N]eovim files" })
-- Shortcut for searching your Neovim configuration files

return {}
