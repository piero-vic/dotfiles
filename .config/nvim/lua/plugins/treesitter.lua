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
    'JoosepAlviste/nvim-ts-context-commentstring',
    opts = { enable_autocmd = true },
    config = function(_, opts)
      require('ts_context_commentstring').setup(opts)

      local get_option = vim.filetype.get_option
      vim.filetype.get_option = function(filetype, option)
        return option == 'commentstring' and require('ts_context_commentstring.internal').calculate_commentstring() or get_option(filetype, option)
      end
    end,
  },
}
