-- Leader key - lazy.nvim needs these set first
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- ╔═══════════════════════════════════════════════════════════════════════════╗
-- ║ Plugins                                                                   ║
-- ╚═══════════════════════════════════════════════════════════════════════════╝

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup('plugins', {
  performance = {
    rtp = {
      disabled_plugins = {
        '2html_plugin',
        'getscript',
        'getscriptPlugin',
        'gzip',
        'logipat',
        -- 'netrw',
        -- 'netrwPlugin',
        -- 'netrwSettings',
        -- 'netrwFileHandlers',
        'matchit',
        'tar',
        'tarPlugin',
        'rrhelper',
        'spellfile_plugin',
        'vimball',
        'vimballPlugin',
        'zip',
        'zipPlugin',
        'tutor',
        'rplugin',
        'synmenu',
        'optwin',
        'compiler',
        'bugreport',
        'ftplugin',
      },
    },
  },
})

-- ╔═══════════════════════════════════════════════════════════════════════════╗
-- ║ Options                                                                   ║
-- ╚═══════════════════════════════════════════════════════════════════════════╝

-- Visual
vim.opt.colorcolumn = { 80, 120 } -- Show color columns
vim.opt.cursorline = true -- Highlight the text line of the cursor
vim.opt.laststatus = 3 -- Enable global status line
vim.opt.number = true -- Show line numbers
vim.opt.pumheight = 10 -- Height of the pop up menu
vim.opt.scrolloff = 8 -- Number of lines to keep above and below the cursor
vim.opt.shortmess:append 'c' -- Minimize file messages
vim.opt.showmode = false -- Disable showing modes in command line
vim.opt.sidescrolloff = 8 -- Number of columns to keep at the sides of the cursor
vim.opt.signcolumn = 'yes' -- Always show the sign column
vim.opt.termguicolors = true -- Enable 24-bit RGB color in the TUI
vim.opt.wrap = false -- Disable wrapping of lines longer than the width of window
vim.opt.fillchars = 'eob: ' -- Hide ~ on blank lines

-- File Explorer
vim.g.netrw_banner = 0 -- Suppress banner
vim.g.netrw_liststyle = 3 -- Tree style listing

-- Search
vim.opt.ignorecase = true -- Case insensitive
vim.opt.smartcase = true -- Case sensitive with upper case

-- Tabs and indentation
vim.opt.expandtab = true -- Enable the use of space in tab
vim.opt.shiftwidth = 2 -- Number of space inserted for indentation
vim.opt.tabstop = 2 -- Number of space in a tab

-- Splits
vim.opt.splitbelow = true -- New window below the current one
vim.opt.splitright = true -- New window at the right of the current one

-- Extra functionality
vim.opt.clipboard = 'unnamedplus' -- System clipboard
vim.opt.completeopt = { 'menuone', 'noselect' } -- Options for insert mode completion
vim.opt.fileencoding = 'utf-8' -- File content encoding for the buffer
vim.opt.iskeyword:append '-' -- Words can have - character
vim.opt.mouse = 'a' -- Enable mouse
vim.opt.swapfile = false -- Disable use of swapfile for the buffer
vim.opt.timeoutlen = 300 -- Length of time to wait for a mapped sequence
vim.opt.undofile = true -- Enable persistent undo
vim.opt.updatetime = 300 -- Length of time to wait before triggering the plugin
vim.opt.whichwrap = 'b,s,<,>,[,],h,l' -- Move cursor to previus/next line after first/last character
vim.opt.writebackup = false -- Disable making a backup before overwriting a file

-- ╔═══════════════════════════════════════════════════════════════════════════╗
-- ║ Keymaps                                                                   ║
-- ╚═══════════════════════════════════════════════════════════════════════════╝

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

-- Telescope
keymap('n', '<leader>fw', require('telescope.builtin').live_grep, opts)
keymap('n', '<leader>ff', require('telescope.builtin').find_files, opts)
keymap('n', '<leader>gc', require('telescope.builtin').git_commits, opts)
keymap('n', '<leader>gs', require('telescope.builtin').git_status, opts)

-- ╔═══════════════════════════════════════════════════════════════════════════╗
-- ║ Autocommands                                                              ║
-- ╚═══════════════════════════════════════════════════════════════════════════╝

-- Filetypes
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = '*.astro',
  command = 'set filetype=astro',
})

vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = '*.mdx',
  command = 'set filetype=markdown',
})

-- Ledger files
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = '*.ledger',
  callback = function()
    vim.opt_local.shiftwidth = 4
    vim.opt_local.commentstring = ';%s'
  end,
})
