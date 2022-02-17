local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Navigate buffers
keymap("n", "<TAB>", ":bnext<CR>", opts)
keymap("n", "<S-TAB>", ":bprevious<CR>", opts)

-- Open file explorer
keymap("n", "<C-N>", ":Lex 15<CR>", opts)

-- Consecutive tabs on visual mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)
