return {
  {
    -- Colorscheme
    'rebelot/kanagawa.nvim',
    priority = 1000,
    config = function()
      vim.cmd 'colorscheme kanagawa'
    end,
  },
  {
    -- Bufferline
    'akinsho/bufferline.nvim',
    dependencies = 'kyazdani42/nvim-web-devicons',
    opts = {},
  },
  {
    -- Status line
    'nvim-lualine/lualine.nvim',
    dependencies = 'kyazdani42/nvim-web-devicons',
    opts = {
      options = {
        component_separators = '|',
        section_separators = '',
      },
    },
  },
  {
    -- Identation guides
    'lukas-reineke/indent-blankline.nvim',
    opts = {
      show_trailing_blankline_indent = false,
      show_current_context = true,
    },
  },
  {
    -- Git info
    'lewis6991/gitsigns.nvim',
    opts = {
      on_attach = function(bufnr)
        -- Navigation
        vim.keymap.set('n', '[h', require('gitsigns').prev_hunk, { buffer = bufnr })
        vim.keymap.set('n', ']h', require('gitsigns').next_hunk, { buffer = bufnr })
        -- Actions
        vim.keymap.set({ 'n', 'v' }, '<leader>hs', require('gitsigns').stage_hunk, { buffer = bufnr })
        vim.keymap.set({ 'n', 'v' }, '<leader>hr', require('gitsigns').reset_hunk, { buffer = bufnr })
        vim.keymap.set('n', '<leader>hu', require('gitsigns').undo_stage_hunk, { buffer = bufnr })
        vim.keymap.set('n', '<leader>bs', require('gitsigns').stage_buffer, { buffer = bufnr })
        vim.keymap.set('n', '<leader>br', require('gitsigns').reset_buffer, { buffer = bufnr })
        vim.keymap.set('n', '<leader>hp', require('gitsigns').preview_hunk, { buffer = bufnr })
      end,
    },
  },
  {
    -- Tree-Sitter
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = 'all',
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },
        context_commentstring = { enable = true, enable_autocmd = false },
      }
    end,
  },
  {
    -- Comments
    'numToStr/Comment.nvim',
    dependencies = 'JoosepAlviste/nvim-ts-context-commentstring',
    opts = {
      pre_hook = function(ctx)
        local U = require 'Comment.utils'

        local location = nil
        if ctx.ctype == U.ctype.block then
          location = require('ts_context_commentstring.utils').get_cursor_location()
        elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
          location = require('ts_context_commentstring.utils').get_visual_start_location()
        end

        return require('ts_context_commentstring.internal').calculate_commentstring {
          key = ctx.ctype == U.ctype.line and '__default' or '__multiline',
          location = location,
        }
      end,
    },
  },
  {
    -- Fuzzy Finder
    'nvim-telescope/telescope.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    opts = {
      defaults = {
        sorting_strategy = 'ascending',
      },
      pickers = {
        find_files = {
          find_command = { 'rg', '--files', '--hidden', '-g', '!.git' },
        },
      },
    },
  },
  {
    -- LSP
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v1.x',
    dependencies = {
      -- LSP Support
      'neovim/nvim-lspconfig',
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      -- Autocompletion
      'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lua',
      -- Snippets
      'L3MON4D3/LuaSnip',
      'rafamadriz/friendly-snippets',
    },
    config = function()
      require 'config.lsp'
    end,
  },
  -- Tmux navigation
  'christoomey/vim-tmux-navigator',
}
