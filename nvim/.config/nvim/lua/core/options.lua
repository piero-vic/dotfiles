local set = vim.opt

-- Visual
set.colorcolumn = "80"
set.cursorline = true
set.number = true
set.relativenumber = true
set.signcolumn = "yes"
set.termguicolors = true
set.wrap = false
set.scrolloff = 8
set.sidescrolloff = 8
set.pumheight = 10
-- Search
set.hlsearch = true
set.ignorecase = true
set.smartcase = true
-- Tab Line
set.showtabline = 2
-- Status Line
set.showmode = false
-- File explore
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
-- Tabs and indentation
set.expandtab = true
set.shiftwidth = 2
set.smartindent = true
set.tabstop = 2
-- Splits
set.splitbelow = true
set.splitright = true
-- Other
set.backup = false
set.clipboard = "unnamedplus"
set.completeopt = { "menuone", "noselect" }
set.conceallevel = 0
set.encoding = "utf-8"
set.fileencoding = "utf-8"
set.hidden = true
set.mouse = "a"
set.swapfile = false
set.timeoutlen = 1000
set.undofile = true
set.updatetime = 300
set.writebackup = false

set.shortmess:append "c"

vim.cmd "set whichwrap+=<,>,[,],h,l"
vim.cmd [[set iskeyword+=-]]
vim.cmd [[set formatoptions-=cro]]
