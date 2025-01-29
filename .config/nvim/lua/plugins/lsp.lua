return {
  -- Additional lua configuration, makes nvim stuff amazing!
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },

  -- Main LSP Configuration
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      -- Adds LSP completion capabilities
      'saghen/blink.cmp',
    },
    config = function()
      local _border = 'rounded'
      vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = _border })
      vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = _border })
      vim.diagnostic.config {
        virtual_text = false,
        severity_sort = true,
        float = {
          style = 'minimal',
          border = _border,
          source = true,
          header = '',
          prefix = '',
        },
      }

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
          map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
          map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
          map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
          map('<leader>e', vim.diagnostic.open_float, 'Show diagnostics')

          vim.api.nvim_buf_create_user_command(event.buf, 'Format', function(_)
            vim.lsp.buf.format()
          end, { desc = 'Format current buffer with LSP' })
        end,
      })

      local servers = {
        angularls = {},
        astro = {},
        bashls = {},
        cssls = {},
        emmet_language_server = {
          filetypes = { 'templ' },
        },
        eslint = {},
        gopls = {},
        ltex = {},
        lua_ls = {},
        markdown_oxide = {},
        prismals = {},
        tailwindcss = {
          settings = {
            tailwindCSS = {
              includeLanguages = {
                templ = 'html',
              },
              emmetCompletions = true,
            },
          },
        },
        templ = {},
        terraformls = {},
        tinymist = {},
        ts_ls = {},
      }

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        -- Formatters
        'prettierd',
        'black',
        'gofumpt',
        'goimports',
        'golines',
        'shfmt',
        'stylua',
        'typstfmt',
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason').setup()
      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },
}
