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

-- Disabled plugins
local default_plugins = {
  -- "netrw",
  -- "netrwPlugin",
  -- "netrwSettings",
  -- "netrwFileHandlers",
  'gzip',
  'zip',
  'zipPlugin',
  'tar',
  'tarPlugin',
  'getscript',
  'getscriptPlugin',
  'vimball',
  'vimballPlugin',
  '2html_plugin',
  'logipat',
  'rrhelper',
  'spellfile_plugin',
  'matchit',
}

for _, plugin in pairs(default_plugins) do
  vim.g['loaded_' .. plugin] = 1
end
