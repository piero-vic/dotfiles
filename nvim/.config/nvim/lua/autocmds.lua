-- Filetypes
vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
  pattern = '*.astro',
  command = 'set filetype=astro',
})

-- Ledger files
vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
  pattern = '*.ledger',
  callback = function()
    vim.opt_local.shiftwidth = 4
    vim.opt_local.commentstring = ';%s'
  end,
})

-- Code formating on save
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*.go',
  callback = function()
    vim.lsp.buf.format()
  end,
})

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = { '*.tsx', '*.ts', '*.jsx', '*.js' },
  command = 'silent! EslintFixAll',
})
