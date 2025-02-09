return {
  'kristijanhusak/vim-dadbod-ui',
  dependencies = {
    { 'tpope/vim-dadbod', lazy = true },
    { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
  },
  keys = {
    {
      '<leader>db',
      function()
        vim.cmd 'DBUIToggle'
      end,
      desc = 'Dad Bod UI',
    },
  },
  init = function()
    vim.g.db_ui_use_nerd_fonts = 1
    vim.g.db_ui_use_postgres_views = 0

    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'dbui',
      callback = function(args)
        -- Disable tab to avoid changing buffers.
        vim.keymap.set('n', '<TAB>', '', { buffer = args.buf })
        vim.keymap.set('n', '<S-TAB>', '', { buffer = args.buf })
      end,
    })
  end,
}
