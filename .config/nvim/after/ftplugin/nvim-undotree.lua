vim.opt_local.number = false
vim.opt_local.relativenumber = false
vim.opt_local.signcolumn = 'no'

vim.keymap.set('n', 'q', function()
  require('undotree').open()
end, { buffer = 0 })
