local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

-- Clear search highlighting
keymap('n', '<leader>c', ':nohlsearch<CR>', opts)

-- Navigate buffers
keymap('n', '<TAB>', ':bnext<CR>', opts)
keymap('n', '<S-TAB>', ':bprevious<CR>', opts)

-- Move text in visual mode
keymap('x', 'K', ":move '<-2<CR>gv-gv", opts)
keymap('x', 'J', ":move '>+1<CR>gv-gv", opts)
keymap('v', '>', '>gv', opts)
keymap('v', '<', '<gv', opts)
