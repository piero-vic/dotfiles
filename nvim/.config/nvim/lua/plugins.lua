local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- Leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Install your plugins here
require('lazy').setup {
  -- Colorschemes
  'rebelot/kanagawa.nvim',
  -- Icons
  'onsails/lspkind.nvim',
  'kyazdani42/nvim-web-devicons',
  -- Buffer and Status lines
  'akinsho/bufferline.nvim',
  'nvim-lualine/lualine.nvim',
  -- Identation guides
  'lukas-reineke/indent-blankline.nvim',
  -- Git info
  'lewis6991/gitsigns.nvim',
  -- LSP
  'VonHeikemen/lsp-zero.nvim',
  'neovim/nvim-lspconfig',
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',
  -- Tree-Sitter
  'nvim-treesitter/nvim-treesitter',
  -- Comments
  { 'numToStr/Comment.nvim', dependencies = 'JoosepAlviste/nvim-ts-context-commentstring' },
  -- Fuzzy Finder
  { 'nvim-telescope/telescope.nvim', dependencies = 'nvim-lua/plenary.nvim' },
  -- Tmux navigation
  'christoomey/vim-tmux-navigator',
  -- Completion
  'hrsh7th/nvim-cmp',
  'saadparwaiz1/cmp_luasnip',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-nvim-lsp',
  -- Snippets
  'L3MON4D3/LuaSnip',
  'rafamadriz/friendly-snippets',
}
