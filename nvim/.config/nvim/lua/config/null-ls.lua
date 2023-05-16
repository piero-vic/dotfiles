local null_ls = require("null-ls")
local mason_null_ls = require("mason-null-ls")

mason_null_ls.setup({
  ensure_installed = {
    "eslint_d",
    "fixjson",
    "gofumpt",
    "goimports-reviser",
    "golines",
    "prettier",
    "shfmt",
    "stylua",
  },
  automatic_installation = false,
  automatic_setup = true,
})

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local diagnostics = null_ls.builtins.diagnostics
local formatting = null_ls.builtins.formatting

null_ls.setup({
  debug = false,
  sources = {
    diagnostics.eslint_d,
    formatting.gofumpt,
    formatting.goimports_reviser,
    formatting.golines,
    formatting.prettier,
    formatting.stylua.with({ extra_args = { "--indent_type", "Spaces", "indent_width", "2" } }),
  },
  on_attach = function(client, bufnr)
    if client.supports_method('textDocument/formatting') then
      vim.api.nvim_clear_autocmds({
        group = augroup,
        buffer = bufnr,
      })
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr })
        end,
      })
    end
  end
})
