-- Automatically install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  command = 'source <afile> | PackerSync',
  group = packer_group,
  pattern = 'plugins.lua',
})

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require('packer.util').float { border = 'single' }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- Have packer manage itself
  use 'wbthomason/packer.nvim'
  -- Visual Plugins
  use 'RRethy/nvim-base16'
  use 'lewis6991/gitsigns.nvim'
  use { 'akinsho/bufferline.nvim', requires = { 'kyazdani42/nvim-web-devicons', opt = true } }
  use { 'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons', opt = true } }
  use 'onsails/lspkind.nvim'
  -- LSP
  use { 'neovim/nvim-lspconfig', 'williamboman/mason.nvim', 'williamboman/mason-lspconfig.nvim' }
  -- Tree-Sitter
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  -- Comments
  use { 'numToStr/Comment.nvim', requires = 'JoosepAlviste/nvim-ts-context-commentstring' }
  -- Telescope
  use { 'nvim-telescope/telescope.nvim', requires = 'nvim-lua/plenary.nvim' }
  -- Completion and Snippets
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lsp',
      'L3MON4D3/LuaSnip',
      'rafamadriz/friendly-snippets',
    },
  }
  -- Markdown
  use {
    'iamcco/markdown-preview.nvim',
    run = 'cd app && npm install',
    setup = function()
      vim.g.mkdp_filetypes = { 'markdown' }
    end,
    ft = { 'markdown' },
  }
  -- Tmux
  use 'christoomey/vim-tmux-navigator'
end)
