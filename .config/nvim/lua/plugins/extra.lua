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
}
