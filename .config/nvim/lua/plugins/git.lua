return {
  'lewis6991/gitsigns.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {
    on_attach = function(bufnr)
      local gitsigns = require 'gitsigns'

      -- Navigation
      vim.keymap.set('n', '[h', function()
        gitsigns.nav_hunk 'prev'
      end, { buffer = bufnr, desc = 'Previous [H]unk' })
      vim.keymap.set('n', ']h', function()
        gitsigns.nav_hunk 'next'
      end, { buffer = bufnr, desc = 'Next [H]unk' })

      -- Actions
      vim.keymap.set({ 'n', 'v' }, '<leader>hs', gitsigns.stage_hunk, { buffer = bufnr })
      vim.keymap.set({ 'n', 'v' }, '<leader>hr', gitsigns.reset_hunk, { buffer = bufnr })
      vim.keymap.set('n', '<leader>bs', gitsigns.stage_buffer, { buffer = bufnr })
      vim.keymap.set('n', '<leader>br', gitsigns.reset_buffer, { buffer = bufnr })
      vim.keymap.set('n', '<leader>hp', gitsigns.preview_hunk, { buffer = bufnr })
      vim.keymap.set('n', '<leader>gb', gitsigns.blame, { buffer = bufnr })
    end,
  },
}
