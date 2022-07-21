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

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Enable the following language servers
local servers = {
  'astro',
  'bashls',
  'emmet_ls',
  'solargraph',
  'sumneko_lua',
  'tailwindcss',
  'tsserver',
}

require('nvim-lsp-installer').setup { ensure_installed = servers, ui = { border = 'single' } }

-- UI
local win = require 'lspconfig.ui.windows'
local _default_opts = win.default_opts

win.default_opts = function(options)
  local opt = _default_opts(options)
  opt.border = 'single'
  return opt
end

vim.diagnostic.config { virtual_text = false, float = { border = 'single' } }
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'single' })
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'single' })

-- Configure servers
for _, server in ipairs(servers) do
  local options = { on_attach = on_attach, capabilities = capabilities }

  local present, server_options = pcall(require, 'config.lsp.server_settings.' .. server)
  if present then
    options = vim.tbl_deep_extend('force', server_options, options)
  end

  require('lspconfig')[server].setup(options)
end
