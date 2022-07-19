local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

-- Diagnostic keymaps
keymap('n', '[d', vim.diagnostic.goto_prev, opts)
keymap('n', ']d', vim.diagnostic.goto_next, opts)
keymap('n', '<leader>e', vim.diagnostic.open_float, opts)
keymap('n', '<leader>q', vim.diagnostic.setloclist, opts)

-- Function that's going to execute after the language server attaches to the current buffer.
local on_attach = function(_, bufnr)
  -- Function that lets us more easily define mappings specific for LSP related items.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    keymap('n', keys, func, { noremap = true, silent = true, buffer = bufnr, desc = desc })
  end

  -- LSP Mappings
  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]tion')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('gr', require('telescope.builtin').lsp_references)
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type Definition')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')
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

require('nvim-lsp-installer').setup {
  ensure_installed = servers,
  ui = { border = 'single' },
}

local win = require 'lspconfig.ui.windows'
local _default_opts = win.default_opts

win.default_opts = function(options)
  local opt = _default_opts(options)
  opt.border = 'single'
  return opt
end

-- Configure servers
for _, server in ipairs(servers) do
  local options = { on_attach = on_attach, capabilities = capabilities }

  local present, server_options = pcall(require, 'config.lsp.server_settings.' .. server)
  if present then
    options = vim.tbl_deep_extend('force', server_options, options)
  end

  require('lspconfig')[server].setup(options)
end
