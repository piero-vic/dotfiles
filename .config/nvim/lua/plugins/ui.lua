return {
  -- Colorscheme
  {
    'rebelot/kanagawa.nvim',
    priority = 1000,
    opts = {
      overrides = function(colors)
        local theme = colors.theme
        return {
          NormalFloat = { bg = 'none' },
          FloatBorder = { bg = 'none' },
          FloatTitle = { bg = 'none' },

          -- Save an hlgroup with dark background and dimmed foreground
          -- so that you can use it where your still want darker windows.
          -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
          NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

          -- Popular plugins that open floats will link to NormalFloat by default;
          -- set their background accordingly if you wish to keep them dark and borderless
          LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
          MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
        }
      end,
    },
    config = function(_, opts)
      require('kanagawa').setup(opts)
      vim.cmd 'colorscheme kanagawa-dragon'
    end,
  },

  -- Tabs
  {
    'akinsho/bufferline.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    opts = {
      options = {
        offsets = {
          { filetype = 'NvimTree', text = 'File Explorer', highlight = 'NormalDark', separator = true },
          { filetype = 'dbui', text = 'Databases', highlight = 'NormalDark', separator = true },
          { filetype = 'calendar', text = 'Calendar', highlight = 'NormalDark', separator = true },
          { filetype = 'gitsigns.blame', text = 'Git Blame', highlight = 'NormalDark', separator = true },
        },
      },
    },
  },

  -- Statusline
  {
    'nvim-lualine/lualine.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    opts = {
      options = {
        component_separators = '│',
        section_separators = '',
      },
    },
  },

  {
    'nvim-tree/nvim-tree.lua',
    opts = {},
    keys = {
      {
        '<leader>ft',
        function()
          require('nvim-tree.api').tree.toggle()
        end,
      },
    },
  },

  -- Identation guides
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {
      indent = { char = '│' },
      scope = { enabled = false },
      exclude = {
        filetypes = { 'markdown' },
      },
    },
  },

  -- Annotated comments
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },

  -- Cloak
  { 'laytan/cloak.nvim', opts = {} },
}
