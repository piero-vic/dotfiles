local M = {}

function M.config()
  local colorscheme = "tokyonight"

  vim.g.tokyonight_style = 'night'
  vim.g.tokyonight_italic_functions = true
  vim.g.tokyonight_transparent = true

  local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
  if not status_ok then
    return
  end
end

return M
