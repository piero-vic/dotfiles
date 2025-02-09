return {
  -- Tmux
  {
    'alexghergh/nvim-tmux-navigation',
    opts = { disable_when_zoomed = true },
    keys = {
      { '<C-h>', '<cmd>NvimTmuxNavigateLeft<cr>' },
      { '<C-j>', '<cmd>NvimTmuxNavigateDown<cr>' },
      { '<C-k>', '<cmd>NvimTmuxNavigateUp<cr>' },
      { '<C-l>', '<cmd>NvimTmuxNavigateRight<cr>' },
    },
  },

  -- Ledger
  { 'ledger/vim-ledger', ft = 'ledger' },

  -- Tailwind Sorter
  -- NOTE: This is for sorting classes in templ files since I cannot use the prettier plugin.
  {
    'laytan/tailwind-sorter.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-lua/plenary.nvim' },
    build = 'cd formatter && npm ci && npm run build',
    opts = {
      on_save_enabled = true,
      on_save_pattern = { '*.templ' },
    },
    ft = { 'templ' },
  },
}
