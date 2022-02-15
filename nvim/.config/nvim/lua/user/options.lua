-- Visual
vim.opt.colorcolumn = "80"
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.termguicolors = true
vim.opt.wrap = false
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.pumheight = 10
-- Search
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
-- Tab Line
vim.opt.showtabline = 2
-- Status Line
vim.opt.showmode = false
-- File explore
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
-- Tabs and indentation
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.tabstop = 2
-- Splits
vim.opt.splitbelow = true
vim.opt.splitright = true
-- Other
vim.opt.backup = false
vim.opt.clipboard = "unnamedplus"
vim.opt.completeopt = { "menuone", "noselect" }
vim.opt.conceallevel = 0
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.hidden = true
vim.opt.mouse = "a"
vim.opt.swapfile = false
vim.opt.timeoutlen = 1000
vim.opt.undofile = true
vim.opt.updatetime = 300
vim.opt.writebackup = false

vim.opt.shortmess:append "c"

vim.cmd "set whichwrap+=<,>,[,],h,l"
vim.cmd [[set iskeyword+=-]]
vim.cmd [[set formatoptions-=cro]]
