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
  nmap('<leader>ca', vim.lsp.buf.code_action)
  nmap('gd', vim.lsp.buf.definition)
  nmap('gD', vim.lsp.buf.declaration)
  nmap('gi', vim.lsp.buf.implementation)
  nmap('gr', require('telescope.builtin').lsp_references)
  nmap('K', vim.lsp.buf.hover)
  nmap('<leader>k', vim.lsp.buf.signature_help)
end)

lsp.format_on_save {
  servers = {
    ['astro'] = { 'astro' },
    ['gopls'] = { 'go' },
    ['jdtls'] = { 'java' },
  },
}

local servers = {
  angularls = {},
  astro = {},
  bashls = {},
  cssls = {},
  dockerls = {},
  emmet_language_server = {},
  eslint = {},
  gopls = {},
  jdtls = {},
  lua_ls = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        library = {
          [vim.fn.expand '$VIMRUNTIME/lua'] = true,
          [vim.fn.stdpath 'config' .. '/lua'] = true,
        },
      },
    },
  },
  marksman = {},
  tailwindcss = {
    tailwindCSS = {
      emmetCompletions = true,
    },
  },
  tsserver = {},
}

lsp.ensure_installed(vim.tbl_keys(servers))

for server_name, server_settings in pairs(servers) do
  lsp.configure(server_name, server_settings)
end

lsp.nvim_workspace()

lsp.setup()
