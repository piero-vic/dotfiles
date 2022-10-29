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
  -- Colorschemes
  use 'RRethy/nvim-base16'
  -- Icons
  use { 'onsails/lspkind.nvim', 'kyazdani42/nvim-web-devicons'}
  -- Buffer and Status lines
  use { 'akinsho/bufferline.nvim', 'nvim-lualine/lualine.nvim' }
  -- Git info
  use 'lewis6991/gitsigns.nvim'
  -- LSP
  use { 'neovim/nvim-lspconfig', 'williamboman/mason.nvim', 'williamboman/mason-lspconfig.nvim' }
  -- Tree-Sitter
  use 'nvim-treesitter/nvim-treesitter'
  -- Comments
  use { 'numToStr/Comment.nvim', requires = 'JoosepAlviste/nvim-ts-context-commentstring' }
  -- Fuzzy Finder
  use { 'nvim-telescope/telescope.nvim', requires = 'nvim-lua/plenary.nvim' }
  -- Tmux navigation
  use 'christoomey/vim-tmux-navigator'
  -- Completion
  use { 'hrsh7th/nvim-cmp', 'saadparwaiz1/cmp_luasnip', 'hrsh7th/cmp-buffer', 'hrsh7th/cmp-path', 'hrsh7th/cmp-nvim-lsp' }
  -- Snippets
  use { 'L3MON4D3/LuaSnip', 'rafamadriz/friendly-snippets' }
end)
