return {
  'saghen/blink.cmp',
  dependencies = 'rafamadriz/friendly-snippets',
  version = '*',
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    completion = {
      menu = {
        draw = {
          columns = { { 'label', 'label_description', gap = 1 }, { 'kind_icon', 'kind', gap = 1 } },
          components = {
            label = {
              text = function(ctx)
                local div_length = 30 - (string.len(ctx.label) + string.len(ctx.label_detail))
                return ctx.label .. string.rep(' ', div_length) .. ctx.label_detail
              end,
            },
          },
        },
      },
      documentation = {
        auto_show = true,
        window = { border = 'rounded' },
      },
    },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer', 'dadbod' },
      cmdline = {},
      providers = {
        dadbod = { name = 'Dadbod', module = 'vim_dadbod_completion.blink' },
      },
    },
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = 'mono',
    },
    keymap = {
      preset = 'default',
      ['<Tab>'] = { 'snippet_forward', 'select_next', 'fallback' },
      ['<S-Tab>'] = { 'snippet_backward', 'select_prev', 'fallback' },
      ['<CR>'] = { 'select_and_accept', 'fallback' },
    },
  },
}
