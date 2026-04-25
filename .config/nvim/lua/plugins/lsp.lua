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
      -- Adds LSP completion capabilities
      'saghen/blink.cmp',
    },
    init = function()
      local go_to_definition = function()
        if vim.bo.filetype ~= 'go' then
          return require('telescope.builtin').lsp_definitions()
        end

        -- Go to definition from go to templ
        vim.lsp.buf.definition {
          on_list = function(options)
            if options == nil or options.items == nil or #options.items == 0 then
              return
            end

            local prefix = options.items[1].filename:match '(.-)_templ%.go$'
            if prefix == nil then
              return vim.lsp.buf.definition()
            end

            local function_name = vim.fn.expand '<cword>'
            options.items[1].filename = prefix .. '.templ'

            vim.fn.setqflist({}, ' ', options)
            vim.api.nvim_command 'cfirst'

            vim.api.nvim_command('silent! /templ ' .. function_name)
          end,
        }
      end

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(mode, rhs, lhs)
            vim.keymap.set(mode, rhs, lhs, { buffer = event.buf })
          end

          -- Extended defaults
          map('n', 'K', function()
            vim.lsp.buf.hover { border = 'rounded', max_width = 120 }
          end)
          map('n', 'grr', require('telescope.builtin').lsp_references)
          map('n', 'gri', require('telescope.builtin').lsp_implementations)
          map('n', 'grt', require('telescope.builtin').lsp_type_definitions)
          map('n', 'gO', require('telescope.builtin').lsp_document_symbols)
          map({ 'i', 's' }, '<C-s>', function()
            vim.lsp.buf.signature_help { border = 'rounded' }
          end)

          -- Extras
          map('n', 'gd', go_to_definition)
          map('n', 'grd', vim.lsp.buf.declaration)
          map({ 'n', 'x' }, 'gq', function()
            vim.lsp.buf.format { async = true }
          end)

          -- Diagnostics
          map('n', '<C-w>d', function()
            vim.diagnostic.open_float { border = 'rounded', source = true }
          end)
        end,
      })

      vim.lsp.config('*', {
        capabilities = require('blink.cmp').get_lsp_capabilities(),
      })

      vim.lsp.enable {
        'astro',
        'bashls',
        'biome',
        'cssls',
        'gopls',
        'jsonls',
        'kotlin_lsp',
        'ltex',
        'lua_ls',
        'marksman',
        'tailwindcss',
        'templ',
        'tinymist',
        'ts_ls',
        'yamlls',
      }
    end,
  },
}
