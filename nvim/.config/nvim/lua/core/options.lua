local options = {
  -- Visual
  colorcolumn = "80,120",
  cursorline = true,
  number = true,
  relativenumber = true,
  signcolumn = "yes",
  termguicolors = true,
  wrap = false,
  scrolloff = 8,
  sidescrolloff = 8,
  pumheight = 10,
  -- Search
  hlsearch = true,
  ignorecase = true,
  smartcase = true,
  -- Status Line
  showmode = false,
  -- Tabs and indentation
  expandtab = true,
  shiftwidth = 2,
  smartindent = true,
  tabstop = 2,
  -- Splits
  splitbelow = true,
  splitright = true,
  -- Other
  backup = false,
  clipboard = "unnamedplus",
  completeopt = { "menuone", "noselect" },
  conceallevel = 0,
  encoding = "utf-8",
  fileencoding = "utf-8",
  hidden = true,
  mouse = "a",
  swapfile = false,
  timeoutlen = 1000,
  undofile = true,
  updatetime = 300,
  writebackup = false
}

vim.opt.shortmess:append "c"

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.cmd "set whichwrap+=<,>,[,],h,l"
vim.cmd [[set iskeyword+=-]]
vim.cmd [[set formatoptions-=cro]]

-- Custom filetypes
vim.cmd [[autocmd BufNewFile,BufRead *.jrnl set ft=markdown]]
vim.cmd [[autocmd FileType markdown setlocal wrap linebreak textwidth=120]]

-- File explore
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
