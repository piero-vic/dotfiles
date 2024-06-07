return {
  'kristijanhusak/vim-dadbod-ui',
  dependencies = {
    'tpope/vim-dadbod',
    'kristijanhusak/vim-dadbod-completion',
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
