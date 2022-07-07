require('nvim-treesitter.configs').setup {
  ensure_installed = 'all',
  sync_install = false,
  highlight = { enable = true },
  context_commentstring = { enable = true, enable_autocmd = false },
}
