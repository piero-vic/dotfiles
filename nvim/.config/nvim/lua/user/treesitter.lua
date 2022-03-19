local M = {}

function M.config()
  local status_ok, treesitter = pcall(require, "nvim-treesitter.configs")
  if not status_ok then
    return
  end

  treesitter.setup {
    ensure_installed = "maintained",
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

  -- Astro files
  local ft_to_parser = require('nvim-treesitter.parsers').filetype_to_parsername
  ft_to_parser.astro = "tsx"
  vim.cmd [[autocmd BufRead,BufEnter *.astro set filetype=astro]]
end

return M
