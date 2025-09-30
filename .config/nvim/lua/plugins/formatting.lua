return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = {
    'ConformInfo',
    'Format',
    'FormatEnable',
    'FormatDisable',
  },
  ---@module "conform"
  ---@type conform.setupOpts
  opts = {
    formatters_by_ft = {
      -- Lua
      lua = { 'stylua' },
      -- JavaScript
      javascript = { 'biome', 'prettierd', stop_after_first = true },
      typescript = { 'biome', 'prettierd', stop_after_first = true },
      -- Go
      go = { 'gofumpt', 'goimports', 'golines' },
      -- Shell
      sh = { 'shfmt' },
      zsh = { 'shfmt' },
      -- Markup
      typst = { 'typstyle' },
      markdown = { 'prettierd' },
      -- SQL
      sql = { 'pg_format' },
      -- Python
      python = { 'black' },
    },
    format_on_save = function(bufnr)
      -- Disable with a global or buffer-local variable
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end
      return { timeout_ms = 500, lsp_format = 'fallback' }
    end,
  },
  init = function()
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
  config = function(_, opts)
    local conform = require 'conform'
    conform.setup(opts)

    vim.api.nvim_create_user_command('Format', function()
      conform.format()
    end, { desc = 'Format current buffer' })

    vim.api.nvim_create_user_command('FormatDisable', function(args)
      if args.bang then
        -- FormatDisable! will disable formatting just for this buffer
        vim.b.disable_autoformat = true
      else
        vim.g.disable_autoformat = true
      end
    end, { desc = 'Disable autoformat-on-save', bang = true })

    vim.api.nvim_create_user_command('FormatEnable', function()
      vim.b.disable_autoformat = false
      vim.g.disable_autoformat = false
    end, { desc = 'Enable autoformat-on-save' })
  end,
}
