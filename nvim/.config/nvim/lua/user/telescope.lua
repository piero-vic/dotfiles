local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

keymap("n", "<leader>ff", "<cmd>lua require('telescope.builtin').find_files({ find_command = {'rg', '--files', '--hidden', '-g', '!.git'} })<cr>", opts)
keymap("n", "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>", opts)
keymap("n", "<leader>gs", "<cmd>lua require('telescope.builtin').buffers()<cr>", opts)
keymap("n", "<leader>gb", "<cmd>lua require('telescope.builtin').git_status()<cr>", opts)
keymap("n", "<leader>gc", "<cmd>lua require('telescope.builtin').git_bcommits()<cr>", opts)
