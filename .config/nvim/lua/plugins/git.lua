return {
  'lewis6991/gitsigns.nvim',
  opts = {
    on_attach = function(bufnr)
      -- Navigation
      vim.keymap.set('n', '[h', require('gitsigns').prev_hunk, { buffer = bufnr })
      vim.keymap.set('n', ']h', require('gitsigns').next_hunk, { buffer = bufnr })
      -- Actions
      vim.keymap.set({ 'n', 'v' }, '<leader>hs', require('gitsigns').stage_hunk, { buffer = bufnr })
      vim.keymap.set({ 'n', 'v' }, '<leader>hr', require('gitsigns').reset_hunk, { buffer = bufnr })
      vim.keymap.set('n', '<leader>hu', require('gitsigns').undo_stage_hunk, { buffer = bufnr })
      vim.keymap.set('n', '<leader>bs', require('gitsigns').stage_buffer, { buffer = bufnr })
      vim.keymap.set('n', '<leader>br', require('gitsigns').reset_buffer, { buffer = bufnr })
      vim.keymap.set('n', '<leader>hp', require('gitsigns').preview_hunk, { buffer = bufnr })
    end,
  },
}
