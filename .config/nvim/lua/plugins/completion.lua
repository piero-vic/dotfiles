return {
  'saghen/blink.cmp',
  event = 'InsertEnter',
  dependencies = {
    'rafamadriz/friendly-snippets',
    'folke/lazydev.nvim',
    'kristijanhusak/vim-dadbod-completion',
  },
  version = '*',
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    completion = {
      documentation = {
        auto_show = true,
        window = { border = 'rounded' },
      },
    },
    sources = {
      default = { 'lsp', 'buffer', 'snippets', 'path' },
      per_filetype = {
        sql = { 'dadbod' },
        lua = { inherit_defaults = true, 'lazydev' },
      },
      providers = {
        dadbod = { name = 'Dadbod', module = 'vim_dadbod_completion.blink' },
        lazydev = { name = 'LazyDev', module = 'lazydev.integrations.blink', score_offset = 100 },
      },
    },
    keymap = { preset = 'enter' },
    cmdline = { enabled = false },
    term = { enabled = false },
  },
}
