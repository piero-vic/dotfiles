return {
  'saghen/blink.cmp',
  event = 'InsertEnter',
  dependencies = {
    'rafamadriz/friendly-snippets',
    'folke/lazydev.nvim',
    'kristijanhusak/vim-dadbod-completion',
    { 'piero-vic/blink-cmp-ledger', dir = '~/code/blink-cmp-ledger' },
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
        ledger = { inherit_defaults = true, 'ledger_accounts', 'ledger_payees' },
      },
      providers = {
        dadbod = { name = 'Dadbod', module = 'vim_dadbod_completion.blink' },
        lazydev = { name = 'LazyDev', module = 'lazydev.integrations.blink', score_offset = 100 },
        ledger_accounts = { name = 'Ledger Payees', module = 'blink-cmp-ledger.accounts' },
        ledger_payees = { name = 'Ledger Accounts', module = 'blink-cmp-ledger.payees' },
      },
    },
    keymap = { preset = 'enter' },
    cmdline = { enabled = false },
    term = { enabled = false },
  },
}
