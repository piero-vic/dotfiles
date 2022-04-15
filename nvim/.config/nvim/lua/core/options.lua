-- Visual
vim.opt.colorcolumn = { 80, 120 }
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.pumheight = 10
vim.opt.relativenumber = true
vim.opt.scrolloff = 8
vim.opt.showmode = false
vim.opt.sidescrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.termguicolors = true
vim.opt.wrap = false
  -- Search
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
  -- Tabs and indentation
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
  -- Splits
vim.opt.splitbelow = true
vim.opt.splitright = true
  -- Other
vim.opt.backup = false
vim.opt.clipboard = "unnamedplus"
vim.opt.completeopt = { "menuone", "noselect" }
vim.opt.conceallevel = 0
vim.opt.fileencoding = "utf-8"
vim.opt.hidden = true
vim.opt.mouse = "a"
vim.opt.shortmess = vim.o.shortmess .. 'c'
vim.opt.swapfile = false
vim.opt.timeoutlen = 1000
vim.opt.undofile = true
vim.opt.updatetime = 300
vim.opt.whichwrap = 'b,s,<,>,[,],h,l'
vim.opt.writebackup = false

-- Disabled plugins
local disabled_built_ins = {
  -- 'netrw',
  -- 'netrwPlugin',
  -- 'netrwSettings',
  -- 'netrwFileHandlers',
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

for _, plugin in pairs(disabled_built_ins) do
  vim.g['loaded_' .. plugin] = 1
end

-- Other Options
vim.cmd [[set iskeyword+=-]]
vim.cmd [[set formatoptions-=cro]]

-- Custom filetypes
vim.cmd [[autocmd BufNewFile,BufRead,BufEnter *.astro set ft=astro]]
vim.cmd [[autocmd BufNewFile,BufRead *.jrnl set ft=markdown]]
vim.cmd [[autocmd FileType markdown setlocal wrap linebreak textwidth=120]]

-- File explore
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3

-- 0.7 Features
if vim.fn.has('nvim-0.7') == 1 then
  vim.opt.laststatus = 3
end
