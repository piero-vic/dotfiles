return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-ui-select.nvim',
  },
  config = function()
    local telescope = require 'telescope'
    local config = require 'telescope.config'
    local builtin = require 'telescope.builtin'

    local vimgrep_arguments = { unpack(config.values.vimgrep_arguments) }
    table.insert(vimgrep_arguments, '--hidden')
    table.insert(vimgrep_arguments, '--glob')
    table.insert(vimgrep_arguments, '!**/.git/*')
    table.insert(vimgrep_arguments, '-L')

    telescope.setup {
      defaults = {
        sorting_strategy = 'ascending',
        vimgrep_arguments = vimgrep_arguments,
      },
      pickers = {
        find_files = {
          find_command = { 'rg', '--files', '--hidden', '--glob', '!**/.git/*', '-L' },
        },
      },
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
    }

    pcall(require('telescope').load_extension, 'ui-select')

    -- General
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Search Help' })
    vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = 'Search Keymaps' })
    vim.keymap.set('n', '<leader>fw', builtin.live_grep, { desc = 'Search by Grep' })
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Search Files' })
    vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = 'Search Diagnostics' })
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Search Buffer' })

    -- Git
    vim.keymap.set('n', '<leader>gl', function()
      builtin.git_commits { initial_mode = 'normal' }
    end, { desc = 'Git Log ' })

    vim.keymap.set('n', '<leader>gs', function()
      builtin.git_status { initial_mode = 'normal' }
    end, { desc = 'Git Status' })
  end,
}
