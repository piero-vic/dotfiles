local execute = vim.api.nvim_command
local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({"git", "clone", "https://github.com/wbthomason/packer.nvim", install_path})
  print "Installing packer close and reopen Neovim..."
  execute 'packadd packer.nvim'
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use "wbthomason/packer.nvim"  -- Have packer manage itself
  use "nvim-lua/popup.nvim"     -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim"   -- Useful lua functions used ny lots of plugins

  -- Visual Plugins
  use {
    'folke/tokyonight.nvim',
    config = function ()
      require("user.colorscheme").config()
    end
  }

  use{
    'akinsho/bufferline.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function ()
      require("user.bufferline").config()
    end
  }

  use {
    'itchyny/lightline.vim',
    config = function ()
      vim.g.lightline = { colorscheme = 'tokyonight' }
    end
  }

  use "airblade/vim-gitgutter"

  -- Telescope
  use {
    'nvim-telescope/telescope.nvim',
    config = function()
      require("user.telescope").config()
    end
  }

  -- Tree-Sitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ":TSUpdate",
    config = function()
      require("user.treesitter").config()
    end
  }

  -- LSP
  use "neovim/nvim-lspconfig"
  use {
    "williamboman/nvim-lsp-installer",
    event = "BufRead",
    config = function()
      require("user.lsp")
    end
  }

  -- Autocomplete
  use {
    "hrsh7th/nvim-cmp",
    config = function()
      require("user.cmp").config()
    end,
  }
  use { "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" }  -- Snippet completion source
  use { "hrsh7th/cmp-buffer", after = "nvim-cmp" }        -- Buffer completion source
  use { "hrsh7th/cmp-path", after = "nvim-cmp" }          -- Path completion source
  use { "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp"}       -- LSP completion source

  -- Snippets
  use "L3MON4D3/LuaSnip"
  use "rafamadriz/friendly-snippets"

  -- Markdown
  use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn install'}
  use "ellisonleao/glow.nvim"

  -- Comments
  use {
    'numToStr/Comment.nvim',
    config = function()
      require("user.comment").config()
    end
  }
  use "JoosepAlviste/nvim-ts-context-commentstring"

  -- Automatically set up your configuration after cloning packer.nvim
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
