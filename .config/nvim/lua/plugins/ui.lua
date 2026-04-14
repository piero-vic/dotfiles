return {
  -- Colorscheme
  {
    'rebelot/kanagawa.nvim',
    priority = 1000,
    opts = {
      overrides = function()
        return {
          NormalFloat = { bg = 'none' },
          FloatBorder = { bg = 'none' },
          FloatTitle = { bg = 'none' },
        }
      end,
      background = { dark = 'dragon', light = 'lotus' },
    },
    config = function(_, opts)
      require('kanagawa').setup(opts)
      vim.cmd 'colorscheme kanagawa'
    end,
  },

  -- Tabs
  {
    'akinsho/bufferline.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      {
        'nvim-mini/mini.bufremove',
        config = function()
          vim.api.nvim_create_user_command('Bdelete', function(opts)
            require('mini.bufremove').delete(0, opts.bang)
          end, { bang = true })

          vim.api.nvim_create_user_command('Bwipeout', function(opts)
            require('mini.bufremove').wipeout(0, opts.bang)
          end, { bang = true })
        end,
      },
    },
    opts = {
      options = {
        close_command = function(bufnr)
          require('mini.bufremove').delete(bufnr)
        end,
        offsets = {
          { filetype = 'NvimTree', text = 'File Explorer', highlight = 'NormalDark', separator = true },
          { filetype = 'dbui', text = 'Databases', highlight = 'NormalDark', separator = true },
          { filetype = 'calendar', text = 'Calendar', highlight = 'NormalDark', separator = true },
          { filetype = 'gitsigns-blame', text = 'Git Blame', highlight = 'NormalDark', separator = true },
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
        globalstatus = true,
      },
    },
  },

  -- Files
  {
    'nvim-tree/nvim-tree.lua',
    opts = {
      view = {
        width = {},
      },
      actions = {
        file_popup = {
          open_win_config = {
            border = 'rounded',
          },
        },
      },
    },
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
    opts = {
      signs = false,
      search = {
        command = 'rg',
        args = {
          '--color=never',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
          '--hidden',
          '--glob',
          '!**/.git/*',
          '--follow',
        },
      },
    },
    config = function(_, opts)
      local todo_comments = require 'todo-comments'
      todo_comments.setup(opts)

      -- Navigation
      vim.keymap.set('n', ']t', todo_comments.jump_next, { desc = 'Next [T]odo Comment' })
      vim.keymap.set('n', '[t', todo_comments.jump_prev, { desc = 'Previous [T]odo Comment' })
    end,
  },

  -- Cloak
  { 'laytan/cloak.nvim', opts = {} },
}
