return {
  'nvim-telescope/telescope.nvim',
  dependencies = 'nvim-lua/plenary.nvim',
  opts = {
    defaults = {
      sorting_strategy = 'ascending',
    },
    pickers = {
      find_files = {
        find_command = { 'rg', '--files', '--hidden', '-g', '!.git' },
      },
    },
  },
}
