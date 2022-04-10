local M = {}

function M.config()
  local status_ok, bufferline = pcall(require, "bufferline")
  if not status_ok then
    return
  end

  bufferline.setup {
    options = {
      tab_size = 20,
      offsets = {{ filetype = "netrw", text = "File Explorer" }},
      show_buffer_close_icons = false,
      show_close_icon = false,
      view = "multiwindow",
      separator_style = {"", ""},
    },
    highlights = {
      fill = {
        guifg = { attribute = "fg", highlight = "#ff0000" },
        guibg = { attribute = "bg", highlight = "TabLine" },
      },
      background = {
        guifg = { attribute = "fg", highlight = "TabLine" },
        guibg = { attribute = "bg", highlight = "TabLine" },
      }
    }
  }
end

return M
