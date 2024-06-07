return {
  -- Zettelkasten
  {
    'renerocksai/telekasten.nvim',
    opts = {
      home = vim.fn.expand '~/documents/vault',
      auto_set_filetype = false,
      auto_set_syntax = false,
      filename_space_subst = '-',
      dailies = 'journal/daily',
      template_new_daily = '.templates/daily',
      command_palette_theme = 'dropdown',
      show_tags_theme = 'dropdown',
    },
    init = function()
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'markdown',
        callback = function()
          vim.wo.conceallevel = 2
        end,
      })
    end,
    config = function(_, opts)
      local tk = require 'telekasten'
      tk.setup(opts)

      vim.keymap.set('n', '<leader>nh', function()
        vim.cmd('e ' .. opts.home .. '/_index.md')
      end)
      vim.keymap.set('n', '<leader>nn', tk.new_note)
      vim.keymap.set('n', '<leader>nd', tk.goto_today)
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

  -- Typst
  {
    'kaarmu/typst.vim',
    init = function()
      vim.g.typst_pdf_viewer = 'xreader'
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
