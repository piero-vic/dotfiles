local M = {}

function M.config()
  local status_ok, telescope = pcall(require, "telescope")
  if not status_ok then
    return
  end

  telescope.setup{
    defaults = {
      prompt_prefix = " ",
      selection_caret = "❯ ",
      path_display = { "truncate" },
    },
    pickers = {
      find_files = {
        theme = "dropdown",
        find_command = {'rg', '--files', '--hidden', '-g', '!.git'}
      }
    }
  }

  local opts = { noremap = true, silent = true }
  local map = vim.api.nvim_set_keymap

  map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", opts)
  map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", opts)
  map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", opts)
  map("n", "<leader>gs", "<cmd>Telescope git_status<CR>", opts)
  map("n", "<leader>gc", "<cmd>Telescope git_commits<CR>", opts)
  map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", opts)
  map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", opts)
end

return M
