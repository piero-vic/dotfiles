return {
  -- Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs',
    opts = {
      ensure_installed = {
        'angular',
        'astro',
        'bash',
        'css',
        'go',
        'html',
        'javascript',
        'lua',
        'markdown',
        'markdown_inline',
        'scss',
        'tsx',
        'typescript',
        'vim',
        'vimdoc',
      },
      sync_install = false,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = true,
      },
      indent = { enable = true },
    },
  },

  -- Comments
  {
    'numToStr/Comment.nvim',
    dependencies = {
      'JoosepAlviste/nvim-ts-context-commentstring',
      opts = { enable_autocmd = false },
    },
    config = function()
      require('Comment').setup {
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      }
    end,
  },
}
