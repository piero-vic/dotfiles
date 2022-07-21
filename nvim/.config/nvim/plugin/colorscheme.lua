local default_colors = require('kanagawa.colors').setup()

local overrides = {
  NormalFloat = { bg = default_colors.sumiInk1 },
  FloatBorder = { bg = default_colors.sumiInk1 },
}

require('kanagawa').setup { overrides = overrides }

vim.cmd 'colorscheme kanagawa'
