local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
keymap({ 'n', 'v' }, '<Space>', '<Nop>', opts)

-- Navigate buffers
keymap('n', '<TAB>', ':bnext<CR>', opts)
keymap('n', '<S-TAB>', ':bprevious<CR>', opts)

-- Open file explorer
keymap('n', '<C-N>', ':Lex 15<CR>', opts)

-- Consecutive tabs on visual mode
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)

-- Move text up and down
keymap('x', 'J', ":move '>+1<CR>gv-gv", opts)
keymap('x', 'K', ":move '<-2<CR>gv-gv", opts)
