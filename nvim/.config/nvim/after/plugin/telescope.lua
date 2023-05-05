local builtin = require('telescope.builtin')
local utils = require('telescope.utils')

-- if in git directory, use git_files, else use find_files
_G.project_files = function()
  local _, ret, _ = utils.get_os_command_output({ 'git', 'rev-parse', '--is-inside-work-tree' })
  if ret == 0 then
    builtin.git_files({prompt_title = 'git files'})
  else
    builtin.find_files({prompt_title = 'project files'})
  end
end


                                      ------------------------------FILES--------------------------

vim.api.nvim_set_keymap('n', '<leader>pf', '<cmd>lua project_files()<CR>', { noremap=true, desc = 'project files' })

-- Search across all files (including vendor) -- Equilevant to phpstorm <Shift> <Shift> include non-project items
vim.keymap.set('n', '<leader>pa', function() builtin.find_files({ prompt_title = 'All files', no_ignore = true }) end, { desc = 'All files' })
vim.keymap.set('n', '<leader>b', builtin.buffers, { desc = 'search across buffers' })


                                      ------------------------------GREPPING--------------------------


--- Testing telescope extension menufacture
vim.keymap.set('n', '<leader>sg', require('telescope').extensions.menufacture.live_grep)

-- Live grep across project files -- Equilevant to phpstorm <Shift> <Cmd> <f> but faster, cause only project files.
vim.keymap.set('n', '<leader>ff', builtin.live_grep, { desc = 'grep project files' })

-- Resume previous telescope usage.
vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = 'resume previous search' })

-- Live grep across all files -- Equilevant to phpstorm <Shift> <Cmd> <f>
vim.keymap.set('n', '<leader>fa', function()
  builtin.live_grep({
    only_sort_text = true,
    prompt_title = 'Search Everywhere',
    additional_args = function(opts)
      return {"-F", "--no-ignore"}
    end
  })
end, { desc = 'grep everywhere' })

                                      ------------------------------SETUP--------------------------

require('telescope').setup{
  defaults = {
    layout_strategy = 'vertical',
    layout_config = {
      vertical = {
        height = 0.9,
        preview_cutoff = 40,
        width = 0.9
      },
    },

    -- Default configuration for telescope goes here:
    -- config_key = value,
    file_ignore_patterns = { "update", "dev", "node_modules", "yarn.lock", "var", "pub" },
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case"
    },
    mappings = {
      i = {
        ["<C-h>"] = "which_key",
        ["<C-j>"] = "move_selection_next",
        ["<C-k>"] = "move_selection_previous",
        ["<C-n>"] = require('telescope.actions').cycle_history_next,
        ["<C-p>"] = require('telescope.actions').cycle_history_prev,
      }
    }
  },
  pickers = {
    live_grep = {
      prompt_title = 'Search inside project',
      additional_args = function(opts)
        return {"-F"}
      end
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = false,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
    },
  },
}

require('telescope').load_extension('fzf')

