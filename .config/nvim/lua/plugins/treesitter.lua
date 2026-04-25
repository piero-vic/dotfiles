return {
  -- Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    branch = 'main',
    init = function()
      local ensureInstalled = {
        'angular',
        'astro',
        'bash',
        'css',
        'go',
        'html',
        'javascript',
        'kotlin',
        'ledger',
        'lua',
        'markdown',
        'markdown_inline',
        'mermaid',
        'prisma',
        'python',
        'scss',
        'sql',
        'terraform',
        'tsx',
        'typescript',
        'typst',
        'vim',
        'vimdoc',
      }

      local alreadyInstalled = require('nvim-treesitter.config').get_installed()
      local parsersToInstall = vim
        .iter(ensureInstalled)
        :filter(function(parser)
          return not vim.tbl_contains(alreadyInstalled, parser)
        end)
        :totable()
      require('nvim-treesitter').install(parsersToInstall)

      vim.api.nvim_create_autocmd('FileType', {
        pattern = { '*' },
        callback = function()
          pcall(vim.treesitter.start)
        end,
      })
    end,
  },

  -- Comments
  {
    'JoosepAlviste/nvim-ts-context-commentstring',
    opts = { enable_autocmd = false },
    config = function(_, opts)
      require('ts_context_commentstring').setup(opts)

      local get_option = vim.filetype.get_option
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.filetype.get_option = function(filetype, option)
        return option == 'commentstring' and require('ts_context_commentstring.internal').calculate_commentstring() or get_option(filetype, option)
      end
    end,
  },
}
