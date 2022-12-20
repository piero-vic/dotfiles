-- ╔═══════════════════════════════════════════════════════════════════════════╗
-- ║ LSP and Autocompletion                                                    ║
-- ╚═══════════════════════════════════════════════════════════════════════════╝

local lsp = require 'lsp-zero'

lsp.preset 'recommended'

lsp.set_preferences {
  suggest_lsp_servers = false,
  set_lsp_keymaps = false,
  sign_icons = {
    error = 'E',
    warn = 'W',
    hint = 'H',
    info = 'I',
  },
}

lsp.on_attach(function(_, bufnr)
  local nmap = function(keys, func)
    vim.keymap.set('n', keys, func, { noremap = true, silent = true, buffer = bufnr })
  end

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
end)

local servers = {
  'astro',
  'cssls',
  'emmet_ls',
  'eslint',
  'gopls',
  'marksman',
  'sumneko_lua',
  'tailwindcss',
  'tsserver',
}

lsp.ensure_installed(servers)

for _, server in ipairs(servers) do
  local present, server_options = pcall(require, 'config.lsp.server_settings.' .. server)
  if present then
    lsp.configure(server, server_options)
  end
end

lsp.setup_nvim_cmp({
  documentation = {
    border = 'single',
  },
})

lsp.setup()

-- ╔═══════════════════════════════════════════════════════════════════════════╗
-- ║ LSP UI Configuration                                                      ║
-- ╚═══════════════════════════════════════════════════════════════════════════╝

require('mason.settings').set { ui = { border = 'single' } }
require('lspconfig.ui.windows').default_options.border = 'single'

vim.api.nvim_set_hl(0, 'LspInfoBorder', { link = 'FloatBorder' })
vim.diagnostic.config { virtual_text = false, float = { border = 'single' } }
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'single' })
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'single' })
