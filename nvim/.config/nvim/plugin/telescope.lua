-- Setup
require('telescope').setup {
  defaults = {
    prompt_prefix = ' ',
    selection_caret = '❯ ',
    sorting_strategy = 'ascending',
    layout_config = {
      horizontal = { prompt_position = 'bottom', preview_width = 0.55, results_width = 0.8 },
      vertical = { mirror = false },
      width = 0.87,
      height = 0.80,
      preview_cutoff = 120,
    },
    path_display = { 'truncate' },
  },
  pickers = {
    find_files = {
      find_command = { 'rg', '--files', '--hidden', '-g', '!.git' },
    },
  },
}

-- Keymaps
local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

keymap('n', '<leader>fw', require('telescope.builtin').live_grep, opts)
keymap('n', '<leader>ff', require('telescope.builtin').find_files, opts)
keymap('n', '<leader>gc', require('telescope.builtin').git_commits, opts)
keymap('n', '<leader>gs', require('telescope.builtin').git_status, opts)
