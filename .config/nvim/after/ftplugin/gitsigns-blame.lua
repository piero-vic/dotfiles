vim.opt_local.colorcolumn = {}

vim.keymap.set('n', 'q', function()
  vim.api.nvim_buf_delete(0, { force = true })
end, { buffer = 0 })
