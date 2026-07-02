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

  -- LeetCode
  {
    'kawre/leetcode.nvim',
    build = ':TSUpdate html', -- if you have `nvim-treesitter` installed
    dependencies = {
      -- include a picker of your choice, see picker section for more details
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
    },
    opts = {
      -- configuration goes here
      lang = 'golang',
    },
  },
}
