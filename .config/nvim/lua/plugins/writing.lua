return {
  -- Zettelkasten
  {
    'nvim-telekasten/telekasten.nvim',
    opts = {
      -- Main paths
      home = vim.fn.expand '~/documents/notes',
      dailies = 'journal',
      weeklies = 'journal',
      templates = 'templates',
      -- Note templates
      template_new_note = 'templates/note.md',
      template_new_daily = 'templates/daily.md',
      template_new_weekly = 'templates/weekly.md',
      -- Images
      image_subdir = 'attachments',
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

      local journal_dir = vim.fs.joinpath(opts.home, opts.dailies)
      local checkboxes = {
        { char = ' ', icon = '', label = 'to-do' },
        { char = '/', icon = '', label = 'incomplete' },
        { char = 'x', icon = '', label = 'done' },
        { char = '>', icon = '󰒊', label = 'forwarded' },
        { char = '<', icon = '󰃭', label = 'scheduling' },
        { char = 'l', icon = '', label = 'location' },
        { char = 'b', icon = '', label = 'bookmark' },
        { char = 'u', icon = '󰔵', label = 'up' },
        { char = 'd', icon = '󰔳', label = 'down' },
      }

      local function goto_home()
        local filepath = vim.fs.joinpath(opts.home, 'index.md')
        vim.cmd.edit(filepath)
      end

      local function goto_tomorrow()
        local filename = os.date('%Y-%m-%d', os.time() + 24 * 60 * 60) .. '.md'
        local filepath = vim.fs.joinpath(journal_dir, filename)
        vim.cmd.edit(filepath)
      end

      local function goto_yesterday()
        local filename = os.date('%Y-%m-%d', os.time() - 24 * 60 * 60) .. '.md'
        local filepath = vim.fs.joinpath(journal_dir, filename)
        vim.cmd.edit(filepath)
      end

      local pickers = require 'telescope.pickers'
      local finders = require 'telescope.finders'
      local conf = require 'telescope.config'

      local function this_week()
        local dates = {}
        local current_day = os.date('*t').wday

        local offset = current_day - 2
        if offset < 0 then
          offset = 6
        end
        local monday_time = os.time() - (offset * 86400)

        for i = 0, 6 do
          local day_time = monday_time + (i * 86400)
          table.insert(dates, os.date('*t', day_time))
        end

        local options = {}

        pickers
          .new(options, {
            prompt_title = 'Week',
            finder = finders.new_table {
              results = dates,
              entry_maker = function(entry)
                local entry_time = os.time { year = entry.year, month = entry.month, day = entry.day }

                local display = os.date('%a, %b %d, %Y', entry_time)
                local filename = os.date('%Y-%m-%d', entry_time) .. '.md'
                local filepath = vim.fs.joinpath(journal_dir, filename)

                if vim.fn.filereadable(filepath) == 1 then
                  display = '󰃭  ' .. display
                else
                  display = '󰃭  ' .. display
                end

                if os.date('%Y-%m-%d', entry_time) == os.date '%Y-%m-%d' then
                  display = display .. ' (Today)'
                end

                return {
                  value = entry,
                  display = display,
                  ordinal = display,
                  path = filepath,
                }
              end,
            },
            sorter = conf.values.generic_sorter(options),
            previewer = conf.values.grep_previewer(options),
          })
          :find()
      end

      local function select_checkbox()
        if vim.bo.filetype ~= 'markdown' then
          return
        end

        local pattern = '%- %[.-%] '

        local line = vim.api.nvim_get_current_line()
        if not line:match(pattern) then
          return
        end

        vim.ui.select(checkboxes, {
          prompt = 'Checkboxes:',
          format_item = function(item)
            return string.format('%s %s', item.icon, item.label)
          end,
        }, function(choice)
          if not choice then
            return
          end

          local checkbox = string.format('- [%s] ', choice.char)
          local modified_line = line:gsub(pattern, checkbox, 1)
          vim.api.nvim_set_current_line(modified_line)
        end)
      end

      vim.keymap.set('n', '<leader>nh', goto_home)
      vim.keymap.set('n', '<leader>nd', tk.goto_today)
      vim.keymap.set('n', '<leader>ndt', goto_tomorrow)
      vim.keymap.set('n', '<leader>ndy', goto_yesterday)
      vim.keymap.set('n', '<leader>nw', this_week)
      vim.keymap.set('n', '<leader>nn', tk.new_note)
      vim.keymap.set('n', '<leader>nt', tk.show_tags) -- TODO: Handle frontmatter tags
      vim.keymap.set('n', '<leader>nf', tk.find_notes)
      vim.keymap.set('n', '<leader>tt', select_checkbox)
    end,
  },

  -- Calendar
  {
    'renerocksai/calendar-vim',
    init = function()
      vim.g.calendar_no_mappings = true

      local augroup = vim.api.nvim_create_augroup('calendar', { clear = true })

      vim.api.nvim_create_autocmd('FileType', {
        group = augroup,
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
    dir = '/home/piero/code/peek.nvim',
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
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      heading = {
        icons = { '󰎤 ', '󰎧 ', '󰎪 ', '󰎭 ', '󰎱 ', '󰎳 ' },
      },
      bullet = {
        icons = { '•' },
      },
      checkbox = {
        unchecked = {
          icon = ' ',
        },
        checked = {
          icon = ' ',
        },
        custom = {
          incomplete = { raw = '[/]', rendered = ' ', highlight = 'RenderMarkdownTodo', scope_highlight = nil },
          forwarded = { raw = '[>]', rendered = '󰒊 ', highlight = 'RenderMarkdownTodo', scope_highlight = nil },
          scheduling = { raw = '[<]', rendered = '󰃭 ', highlight = 'RenderMarkdownTodo', scope_highlight = nil },
          location = { raw = '[l]', rendered = ' ', highlight = 'RenderMarkdownTodo', scope_highlight = nil },
          bookmark = { raw = '[b]', rendered = ' ', highlight = 'RenderMarkdownTodo', scope_highlight = nil },
          up = { raw = '[u]', rendered = '󰔵 ', highlight = 'RenderMarkdownTodo', scope_highlight = nil },
          down = { raw = '[d]', rendered = '󰔳 ', highlight = 'RenderMarkdownTodo', scope_highlight = nil },
        },
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
      html = {
        comment = {
          conceal = false,
        },
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
