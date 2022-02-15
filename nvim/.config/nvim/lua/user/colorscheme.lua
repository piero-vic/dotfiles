local colorscheme = "tokyonight"

vim.g.tokyonight_style = 'night'
vim.g.tokyonight_italic_functions = true

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end

vim.cmd[[let g:lightline = {'colorscheme': 'tokyonight'}]]
