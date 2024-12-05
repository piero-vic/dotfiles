return {
  -- Zettelkasten
  {
    'nvim-telekasten/telekasten.nvim',
    opts = {
      -- Main paths
      home = vim.fn.expand '~/documents/vault',
      dailies = 'journal',
      weeklies = 'journal',
      templates = '.templates',
      -- Note templates
      template_new_note = '.templates/note.md',
      template_new_daily = '.templates/daily.md',
      template_new_weekly = '.templates/weekly.md',
      -- Images
      image_subdir = 'assets',
      image_link_style = 'markdown',
      -- Notes
      new_note_filename = 'title',
      filename_space_subst = '-',
      filename_small_case = true,
      -- UI
      journal_auto_open = true,
      command_palette_theme = 'dropdown',
      show_tags_theme = 'dropdown',
      -- Filetype
      auto_set_filetype = false,
      auto_set_syntax = false,
    },
    config = function(_, opts)
      local tk = require 'telekasten'
      tk.setup(opts)

      local function goto_home()
        vim.cmd('e ' .. opts.home .. '/index.md')
      end

      local journal_dir = opts.home .. '/' .. opts.dailies

      local function goto_tomorrow()
        local filename = os.date('%Y-%m-%d', os.time() + 24 * 60 * 60) .. '.md'
        vim.cmd('e ' .. journal_dir .. '/' .. filename)
      end

      local function goto_yesterday()
        local filename = os.date('%Y-%m-%d', os.time() - 24 * 60 * 60) .. '.md'
        vim.cmd('e ' .. journal_dir .. '/' .. filename)
      end

      local date_pattern = '(%d+)-(%d+)-(%d+).md'

      local function goto_next_date()
        local current_filename = vim.api.nvim_buf_get_name(0)
        local year, month, day = current_filename:match(date_pattern)

        local next_date = os.time { year = year, month = month, day = day } + 24 * 60 * 60
        local date_table = os.date('*t', next_date)

        tk.CalendarAction(date_table.day, date_table.month, date_table.year)
      end

      local function goto_prev_date()
        local current_filename = vim.api.nvim_buf_get_name(0)
        local year, month, day = current_filename:match(date_pattern)

        local prev_date = os.time { year = year, month = month, day = day } - 24 * 60 * 60
        local date_table = os.date('*t', prev_date)

        tk.CalendarAction(date_table.day, date_table.month, date_table.year)
      end

      vim.keymap.set('n', '<leader>nh', goto_home)

      vim.keymap.set('n', '<leader>nd', tk.goto_today)
      vim.keymap.set('n', '<leader>ndf', goto_next_date)
      vim.keymap.set('n', '<leader>ndb', goto_prev_date)
      vim.keymap.set('n', '<leader>ndt', goto_tomorrow)
      vim.keymap.set('n', '<leader>ndy', goto_yesterday)

      vim.keymap.set('n', '<leader>nn', tk.new_note)
      vim.keymap.set('n', '<leader>nw', tk.goto_thisweek)
      vim.keymap.set('n', '<leader>nt', tk.show_tags)
      vim.keymap.set('n', '<leader>nf', tk.find_notes)
      vim.keymap.set('n', '<leader>tt', tk.toggle_todo)
    end,
  },

  -- Calendar
  {
    'renerocksai/calendar-vim',
    init = function()
      vim.g.calendar_no_mappings = true

      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'calendar',
        callback = function(args)
          vim.wo.signcolumn = 'no'
          vim.wo.number = false
          vim.wo.relativenumber = false
          vim.wo.scrolloff = 0
          vim.wo.sidescrolloff = 0
          vim.cmd 'setlocal nobuflisted'

          -- Disable tab to avoid changing buffers.
          vim.keymap.set('n', '<TAB>', '', { buffer = args.buf })
          vim.keymap.set('n', '<S-TAB>', '', { buffer = args.buf })
        end,
      })
    end,
    keys = {
      {
        '<leader>cal',
        function()
          vim.cmd 'CalendarVR'
        end,
        desc = 'Open Calendar',
      },
    },
  },

  -- Markdown Preview
  {
    'toppair/peek.nvim',
    dir = '/home/piero/code/open-source/peek.nvim',
    build = 'deno task --quiet build:fast',
    opts = {
      close_on_bdelete = false,
      app = 'qutebrowser',
      filetype = { 'markdown' },
    },
    ft = 'markdown',
    keys = {
      {
        '<leader>op',
        ft = 'markdown',
        function()
          local peek = require 'peek'
          if peek.is_open() then
            peek.close()
          else
            peek.open()
          end
        end,
        desc = 'Markdown Preview',
      },
    },
  },

  {
    'MeanderingProgrammer/render-markdown.nvim',
    ft = 'markdown',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
    opts = {
      bullet = {
        icons = { '•' },
      },
      pipe_table = {
        style = 'normal',
      },
      link = {
        enabled = false,
      },
      sign = {
        enabled = false,
      },
    },
  },

  -- Typst
  {
    'kaarmu/typst.vim',
    init = function()
      vim.g.typst_pdf_viewer = 'zathura'
    end,
    ft = 'typst',
    keys = {
      {
        '<leader>op',
        ft = 'typst',
        function()
          vim.cmd 'TypstWatch'
        end,
        desc = 'Typst Preview',
      },
    },
  },
}
