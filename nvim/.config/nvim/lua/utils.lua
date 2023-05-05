local M = {}

function M.edit_neovim()
    require('telescope.builtin').find_files {
        prompt_title = "~ Neovim Config ~",
        cwd = "~/.config/nvim",
        shorten_path = true,
        find_commmand = "rg",
    }
end

return M
