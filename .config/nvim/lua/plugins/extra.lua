return {
  -- Tmux
  {
    'alexghergh/nvim-tmux-navigation',
    opts = { disable_when_zoomed = true },
    config = function(_, opts)
      local nvim_tmux_nav = require 'nvim-tmux-navigation'

      nvim_tmux_nav.setup(opts)

      vim.keymap.set('n', '<C-h>', nvim_tmux_nav.NvimTmuxNavigateLeft)
      vim.keymap.set('n', '<C-j>', nvim_tmux_nav.NvimTmuxNavigateDown)
      vim.keymap.set('n', '<C-k>', nvim_tmux_nav.NvimTmuxNavigateUp)
      vim.keymap.set('n', '<C-l>', nvim_tmux_nav.NvimTmuxNavigateRight)
    end,
    keys = { '<C-h>', '<C-j>', '<C-k>', '<C-l>' },
  },

  -- Ledger
  { 'ledger/vim-ledger', ft = 'ledger' },

  -- Tailwind Sorter
  -- NOTE: This is for sorting classes in templ files since I cannot use the prettier plugin.
  {
    'laytan/tailwind-sorter.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-lua/plenary.nvim' },
    build = 'cd formatter && npm ci && npm run build',
    config = true,
    ft = { 'templ' },
  },
}
