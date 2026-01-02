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
      local hover = function()
        vim.lsp.buf.hover { border = 'rounded' }
      end

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

            local targetFile = options.items[1].filename
            local prefix = string.match(targetFile, '(.-)_templ%.go$')

            if prefix then
              local function_name = vim.fn.expand '<cword>'
              options.items[1].filename = prefix .. '.templ'

              vim.fn.setqflist({}, ' ', options)
              vim.api.nvim_command 'cfirst'

              vim.api.nvim_command('silent! /templ ' .. function_name)
            else
              vim.lsp.buf.definition()
            end
          end,
        }
      end

      local show_diagnostics = function()
        vim.diagnostic.open_float { border = 'rounded' }
      end

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(mode, rhs, lhs)
            vim.keymap.set(mode, rhs, lhs, { buffer = event.buf })
          end

          -- Extended defaults
          map('n', 'K', hover)
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
          map('n', '<C-w>d', show_diagnostics)
        end,
      })

      vim.lsp.config('*', {
        capapilities = require('blink.cmp').get_lsp_capabilities(),
      })

      vim.lsp.enable {
        'astro',
        'bashls',
        'biome',
        'cssls',
        'gopls',
        'ltex',
        'lua_ls',
        'marksman',
        'tailwindcss',
        'templ',
        'tinymist',
        'ts_ls',
      }
    end,
  },
}
