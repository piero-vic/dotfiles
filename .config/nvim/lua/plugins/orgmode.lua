return {
  {
    'nvim-orgmode/orgmode',
    tag = '0.7.3',
    event = 'VeryLazy',
    ft = { 'org' },
    config = function()
      -- Setup orgmode
      require('orgmode').setup {
        -- Global settings
        org_agenda_files = {
          '~/documents/orgfiles/*',
          '~/documents/orgfiles/notes/*',
        },
        org_default_notes_file = '~/documents/orgfiles/inbox.org',
        org_startup_folded = 'showeverything',
        org_ellipsis = ' [...]',
        org_startup_indented = true,

        -- Agenda settings
        org_deadline_warning_days = 7,
        org_capture_templates = {
          t = { description = 'Task', template = '* TODO %?\n%u' },
        },
        org_agenda_skip_deadline_if_done = true,

        -- User Interface
        ui = {
          input = {
            use_vim_ui = true,
          },
          agenda = {
            preview_window = {
              border = 'rounded',
            },
          },
        },
      }

      -- Experimental LSP support
      vim.lsp.enable 'org'
    end,
  },
  {
    'chipsenkbeil/org-roam.nvim',
    tag = '0.2.0',
    dependencies = {
      'nvim-orgmode/orgmode',
    },
    config = function()
      local roam = require 'org-roam'

      roam.setup {
        directory = '~/documents/orgfiles/',
        bindings = false,
      }

      -- NOTE: Set these manually if needed
      -- https://github.com/chipsenkbeil/org-roam.nvim/blob/main/DOCS.org#dailies-1

      vim.keymap.set('n', '<leader>nrdb', function()
        roam.ext.dailies.goto_prev_date()
      end)

      vim.keymap.set('n', '<leader>nrdf', function()
        roam.ext.dailies.goto_next_date()
      end)

      vim.keymap.set('n', '<leader>nrdd', function()
        roam.ext.dailies.goto_date()
      end)

      vim.keymap.set('n', '<leader>nrdy', function()
        roam.ext.dailies.goto_yesterday()
      end)

      vim.keymap.set('n', '<leader>nrdt', function()
        roam.ext.dailies.goto_today()
      end)

      vim.keymap.set('n', '<leader>nrdm', function()
        roam.ext.dailies.goto_tomorrow()
      end)
    end,
  },
  {
    'cvigilv/denote.nvim',
    dir = '~/code/denote.nvim',
    dependencies = {
      'nvim-telescope/telescope.nvim',
    },
    lazy = false,
    init = function()
      vim.g.denote = {
        filetype = 'org',
        directory = '~/documents/orgfiles/notes',
        prompts = { 'signature', 'title', 'keywords' },
        integrations = {
          oil = false,
          telescope = true,
        },
      }

      pcall(require('telescope').load_extension, 'denote')

      vim.keymap.set('n', '<leader>nn', function()
        vim.cmd 'Denote'
      end)
      vim.keymap.set('n', '<leader>nf', function()
        vim.cmd 'Telescope denote search'
      end)
    end,
  },
}
