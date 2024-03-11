return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-ui-select.nvim',
  },
  config = function()
    require('telescope').setup {
      defaults = {
        sorting_strategy = 'ascending',
      },
      pickers = {
        find_files = {
          find_command = { 'rg', '--files', '--hidden', '-g', '!.git' },
        },
      },
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
    }

    pcall(require('telescope').load_extension, 'ui-select')

    -- Telescope
    vim.keymap.set('n', '<leader>fw', require('telescope.builtin').live_grep)
    vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files)
    vim.keymap.set('n', '<leader>gl', ':Telescope git_commits initial_mode=normal<CR>')
    vim.keymap.set('n', '<leader>gs', ':Telescope git_status initial_mode=normal<CR>')
  end,
}
