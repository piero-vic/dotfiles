return {
  -- Colorscheme
  {
    'rebelot/kanagawa.nvim',
    priority = 1000,
    config = function()
      require('kanagawa').setup {
        overrides = function(colors)
          local theme = colors.theme
          return {
            NormalFloat = { bg = 'none' },
            FloatBorder = { bg = 'none' },
            FloatTitle = { bg = 'none' },
            NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
            LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
            MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
            TelescopeTitle = { fg = theme.ui.special, bold = true },
            TelescopePromptNormal = { bg = theme.ui.bg_p1 },
            TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
            TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
            TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
            TelescopePreviewNormal = { bg = theme.ui.bg_dim },
            TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
          }
        end,
      }

      vim.cmd 'colorscheme kanagawa'
    end,
  },

  -- Bufferline
  {
    'akinsho/bufferline.nvim',
    dependencies = 'kyazdani42/nvim-web-devicons',
    opts = {},
  },

  -- Status line
  {
    'nvim-lualine/lualine.nvim',
    dependencies = 'kyazdani42/nvim-web-devicons',
    opts = {
      options = {
        component_separators = '|',
        section_separators = '',
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

  -- Git
  {
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

  -- Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
      ensure_installed = 'all',
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = true },
    },
    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)
    end,
  },

  -- Comments
  {
    'numToStr/Comment.nvim',
    dependencies = {
      'JoosepAlviste/nvim-ts-context-commentstring',
      opts = { enable_autocmd = false },
    },
    config = function ()
      require('Comment').setup {
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      }
    end,
  },

  -- Telescope
  {
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

  -- LSP Zero
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    lazy = true,
    config = false,
    init = function()
      -- Disable automatic setup, we are doing it manually
      vim.g.lsp_zero_extend_cmp = 0
      vim.g.lsp_zero_extend_lspconfig = 0
    end,
  },

  -- Manage LSP servers from neovim
  { 'williamboman/mason.nvim', lazy = false, config = true },
  { 'williamboman/mason-lspconfig.nvim' },

  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-path',
      'L3MON4D3/LuaSnip',
      'rafamadriz/friendly-snippets',
    },
    config = function()
      local lsp_zero = require 'lsp-zero'
      lsp_zero.extend_cmp()

      local cmp = require 'cmp'
      local cmp_action = lsp_zero.cmp_action()
      local cmp_format = lsp_zero.cmp_format()

      require('luasnip.loaders.from_vscode').lazy_load()

      vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

      cmp.setup {
        formatting = cmp_format,
        preselect = 'item',
        completion = {
          completeopt = 'menu,menuone,noinsert',
        },
        window = {
          documentation = cmp.config.window.bordered(),
        },
        sources = {
          { name = 'path' },
          { name = 'nvim_lsp' },
          { name = 'nvim_lua' },
          { name = 'buffer', keyword_length = 3 },
          { name = 'luasnip', keyword_length = 2 },
        },
        mapping = cmp.mapping.preset.insert {
          -- confirm completion item
          ['<CR>'] = cmp.mapping.confirm { select = false },

          -- toggle completion menu
          ['<C-e>'] = cmp_action.toggle_completion(),

          -- tab complete
          ['<Tab>'] = cmp_action.tab_complete(),
          ['<S-Tab>'] = cmp.mapping.select_prev_item(),

          -- navigate between snippet placeholder
          ['<C-d>'] = cmp_action.luasnip_jump_forward(),
          ['<C-b>'] = cmp_action.luasnip_jump_backward(),

          -- scroll documentation window
          ['<C-f>'] = cmp.mapping.scroll_docs(5),
          ['<C-u>'] = cmp.mapping.scroll_docs(-5),
        },
      }
    end,
  },

  -- LSP Support
  {
    'neovim/nvim-lspconfig',
    cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'williamboman/mason-lspconfig.nvim',
    },
    config = function()
      local lsp_zero = require 'lsp-zero'
      lsp_zero.extend_lspconfig()

      lsp_zero.set_sign_icons {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I',
      }

      vim.diagnostic.config {
        virtual_text = false,
        severity_sort = true,
        float = {
          style = 'minimal',
          border = 'rounded',
          source = 'always',
          header = '',
          prefix = '',
        },
      }

      lsp_zero.on_attach(function(_, bufnr)
        local nmap = function(keys, func)
          vim.keymap.set('n', keys, func, { noremap = true, silent = true, buffer = bufnr })
        end

        nmap('[d', vim.diagnostic.goto_prev)
        nmap(']d', vim.diagnostic.goto_next)
        nmap('<leader>e', vim.diagnostic.open_float)
        nmap('<leader>q', require('telescope.builtin').diagnostics)
        nmap('<leader>rn', vim.lsp.buf.rename)
        nmap('<leader>ca', vim.lsp.buf.code_action)
        nmap('gd', vim.lsp.buf.definition)
        nmap('gD', vim.lsp.buf.declaration)
        nmap('gi', vim.lsp.buf.implementation)
        nmap('gr', require('telescope.builtin').lsp_references)
        nmap('K', vim.lsp.buf.hover)
        nmap('<leader>k', vim.lsp.buf.signature_help)
      end)

      require('mason').setup {}
      require('mason-lspconfig').setup {
        ensure_installed = {
          'angularls',
          'astro',
          'bashls',
          'cssls',
          'emmet_language_server',
          'eslint',
          'gopls',
          'lua_ls',
          'marksman',
          'tailwindcss',
        },
        handlers = {
          lsp_zero.default_setup,
          lua_ls = function()
            local lua_opts = lsp_zero.nvim_lua_ls()
            require('lspconfig').lua_ls.setup(lua_opts)
          end,
          tailwindcss = function()
            require('lspconfig').tailwindcss.setup {
              settings = {
                tailwindCSS = {
                  emmetCompletions = true,
                },
              },
            }
          end,
        },
      }
    end,
  },

  -- Formatter
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        go = { 'gofumpt', 'goimports', 'golines' },

        astro = { 'prettierd' },
        css = { 'prettierd' },
        scss = { 'prettierd' },
        javascript = { 'prettierd' },
        javascriptreact = { 'prettierd' },
        typescript = { 'prettierd' },
        typescriptreact = { 'prettierd' },
        markdown = { 'prettierd' },

        lua = { 'stylua' },

        sh = { 'shfmt' },
        zsh = { 'shfmt' },
      },
      format_on_save = {
        timeout_ms = 500,
      },
    },
  },

  -- Tmux navigation
  'christoomey/vim-tmux-navigator',
}
