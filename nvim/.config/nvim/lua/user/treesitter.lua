local M = {}

function M.config()
  local status_ok, treesitter = pcall(require, "nvim-treesitter.configs")
  if not status_ok then
    return
  end

  treesitter.setup {
    ensure_installed = "all",
    sync_install = false,
    ignore_install = { "" },
    highlight = {
      enable = true,
      disable = { "" },
      additional_vim_regex_highlighting = true
    },
    context_commentstring = {
      enable = true,
      enable_autocmd = false
    }
  }
end

return M
