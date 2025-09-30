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
      { 'mason-org/mason.nvim', opts = {} },
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
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          map('K', hover, 'Hover')
          map('gd', go_to_definition, '[G]oto [D]efinition')
          map('<C-w>d', show_diagnostics, 'Show diagnostics')
          map('grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
          map('gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
          map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')
          map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')
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
        'prismals',
        'tailwindcss',
        'templ',
        'tinymist',
        'ts_ls',
      }
    end,
  },
}
