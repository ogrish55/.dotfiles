local utils = require("utils")

-- CUSTOM UTILS KEYMAPS
-- copying current file path like in phpstorm
vim.keymap.set("n", "<leader>cf", utils.copyCurrentFilePath)

vim.keymap.set("n", "<leader>bdi", utils.deleteVendorBuffers, { desc = "[B]uff [D]elete [I]gnored" })

-- GIT
vim.keymap.set("n", "<leader>gb", function()
	require("gitsigns").blame()
end, { desc = "[G]it [B]lame" })

--
-- Diagnostic keymaps
-- vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
--
-- Quickfix keymaps
vim.keymap.set("n", "<C-n>", "<cmd>cnext<CR>")
vim.keymap.set("n", "<C-p>", "<cmd>cprev<CR>")

-- vim.keymap.set("n", "<C-p>", "g;", { desc = "Go to previous change" })
-- vim.keymap.set("n", "<C-n>", "g,", { desc = "Go to next change" })

--------------FZFLUA KEYMAPS--------------
vim.keymap.set("n", "<leader>r", function()
	require("fzf-lua").live_grep()
end, { desc = "[S]earch Everywhere" })

vim.keymap.set("n", "<leader>sr", function()
	require("fzf-lua").live_grep()
end, { desc = "[S]earch Everywhere" })

vim.keymap.set("n", "<leader>sg", function()
	require("fzf-lua").live_grep({
		rg_opts = table.concat({
			"--column --line-number --no-heading --color=always --hidden --smart-case --max-columns=4096 -F ",
			"-g !dev/ -g !dev/** -g !vendor/**/tests/ -g !vendor/**/Test/ -g !vendor/composer/ ",
			"-g !sync/ -g !lib/ -g !.idea/ -g !setup/ -g !.wexo/app/ -g !.wexo/**/*.sql ",
			"-g !.wexo/restore/ -g !.wexo/.local/ -g !generated/ -g !pub/ -g !var/ -g !logs/ ",
			"-g !CHANGELOG.md -g !node_modules/ -g !dist/ -g !.git/ -g !public/ ",
			"-g !yarn.lock -g !composer.lock ",
		}),
	})
end, { desc = "[S]earch Git" })

vim.keymap.set("n", "<leader>e", function()
	require("fzf-lua").buffers()
end, { desc = "[F]ind [E]xisting buffers" })

vim.keymap.set("n", "<leader>w", function()
	require("fzf-lua").files()
end, { desc = "[F]ind [F]iles" })

vim.keymap.set("n", "<leader>q", function()
	require("fzf-lua").files()
end, { desc = "[F]ind [F]iles" })

vim.keymap.set("n", "<leader>ff", function()
	require("fzf-lua").files()
end, { desc = "[F]ind [F]iles" })

vim.keymap.set("n", "<leader>fq", function()
	require("fzf-lua").files()
end, { desc = "[F]ind [F]iles" })

vim.keymap.set("n", "<leader>fw", function()
	require("fzf-lua").files()
end, { desc = "[F]ind [F]iles" })

vim.keymap.set("n", "<leader>fg", function()
	require("fzf-lua").git_files()
end, { desc = "[F]ind [G]it files" })

vim.keymap.set("n", "<leader>fe", function()
	require("fzf-lua").buffers({ cwd_only = false, sort_lastued = true, fzf_opts = { ["--with-nth"] = "3.." } })
end, { desc = "Buffer All" })

vim.keymap.set("n", "<leader>fo", function()
	require("fzf-lua").oldfiles()
end, { desc = "[F]ind [O]ld files" })

vim.keymap.set("n", "<leader>x", function()
	require("fzf-lua").lsp_document_symbols()
end)

vim.keymap.set("n", "<leader>sh", function()
	require("fzf-lua").helptags({ actions = { ["default"] = require("fzf-lua.actions").file_vsplit } })
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

-- Diagnostic
vim.keymap.set("n", "<leader>n", function()
	vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARN })
end, { desc = "Diagnostic Next" })

vim.keymap.set("n", "<leader>p", function()
	vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.WARN })
end, { desc = "Diagnostic Previous" })

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "n", "nzzzv")

vim.keymap.set("n", "-", "<C-6>")
vim.keymap.set("v", "p", '"_dP')
return {}
