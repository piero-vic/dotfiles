return {
  -- Markdown
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
      code = {
        border = 'thick',
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
