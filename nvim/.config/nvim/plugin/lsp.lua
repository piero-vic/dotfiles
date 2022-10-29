-- ╔═══════════════════════════════════════════════════════════════════════════╗
-- ║ Mason and LSP UI                                                          ║
-- ╚═══════════════════════════════════════════════════════════════════════════╝

require('mason').setup { ui = { border = 'single' } }
require('lspconfig.ui.windows').default_options.border = 'single'

vim.api.nvim_set_hl(0, 'LspInfoBorder', { link = 'FloatBorder' })
vim.diagnostic.config { virtual_text = false, float = { border = 'single' } }
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'single' })
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'single' })

-- ╔═══════════════════════════════════════════════════════════════════════════╗
-- ║ Configure Servers                                                         ║
-- ╚═══════════════════════════════════════════════════════════════════════════╝

-- Function that's going to execute after the language server attaches to the current buffer.
local on_attach = function(_, bufnr)
  -- Function that lets us more easily define mappings specific for LSP related items.
  local nmap = function(keys, func)
    vim.keymap.set('n', keys, func, { noremap = true, silent = true, buffer = bufnr })
  end

  -- Keymaps
  nmap('[d', vim.diagnostic.goto_prev)
  nmap(']d', vim.diagnostic.goto_next)
  nmap('<leader>e', vim.diagnostic.open_float)
  nmap('<leader>q', require('telescope.builtin').diagnostics)
  nmap('<leader>rn', vim.lsp.buf.rename)
  nmap('gd', vim.lsp.buf.definition)
  nmap('gD', vim.lsp.buf.declaration)
  nmap('gi', vim.lsp.buf.implementation)
  nmap('gr', require('telescope.builtin').lsp_references)
  nmap('K', vim.lsp.buf.hover)
  nmap('<leader>k', vim.lsp.buf.signature_help)
end

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

local servers = {
  'astro',
  'bashls',
  'cssls',
  'cssmodules_ls',
  'emmet_ls',
  'marksman',
  'prismals',
  'solargraph',
  'sumneko_lua',
  'tailwindcss',
  'tsserver',
}

require('mason-lspconfig').setup {
  ensure_installed = servers,
  automatic_installation = true,
}

for _, server in ipairs(servers) do
  local options = { on_attach = on_attach, capabilities = capabilities }

  local present, server_options = pcall(require, 'config.lsp.server_settings.' .. server)
  if present then
    options = vim.tbl_deep_extend('force', server_options, options)
  end

  require('lspconfig')[server].setup(options)
end
