" █▄ █ ██▀ ▄▀▄ █ █ █ █▄ ▄█
" █ ▀█ █▄▄ ▀▄▀ ▀▄▀ █ █ ▀ █

"--------------------------
" GENERAL
"--------------------------

" Visual
syntax enable
set conceallevel=0                  " So that I can see `` in markdown files
set nowrap
set ruler
set number
set relativenumber
set showtabline=2                   " Always show tabs
set laststatus=2                    " Always show the status line
set noshowmode                      " No need to see things like -- INSERT -- anymore
set background=dark
set cursorline
set termguicolors
set t_Co=256

" Tabs and indentation
set tabstop=2
set shiftwidth=2
set smarttab
set expandtab
set smartindent
set autoindent

" Other functionalities
set hidden
set mouse=a
set clipboard=unnamedplus           " Copy paste between vim and everithing else
set encoding=utf-8
set fileencoding=utf-8
set iskeyword+=-
set nobackup
set nowritebackup
set updatetime=300
set timeoutlen=500
set formatoptions-=cro
set splitbelow
set splitright

au! BufWritePost

" You can't stop me
cmap w!! w !sudo tee %

"--------------------------
" KEY MAPPINGS
"--------------------------

let g:mapleader = "\<Space>"

" Better nav for omnicomplete
inoremap <expr> <c-j> ("\<C-n>")
inoremap <expr> <c-k> ("\<C-p>")

" Use alt + hjkl to resize windows
nnoremap <M-j>    :resize -2<CR>
nnoremap <M-k>    :resize +2<CR>
nnoremap <M-h>    :vertical resize -2<CR>
nnoremap <M-l>    :vertical resize +2<CR>

" I hate escape more than anything else
inoremap jk <Esc>
inoremap kj <Esc>

" Easy CAPS
inoremap <c-u> <ESC>viwUi
nnoremap <c-u> viwU<Esc>

" Tabs
nnoremap <TAB> gt
nnoremap <S-TAB> gT
nnoremap <c-t> :tabnew<CR>

" <TAB>: completion.
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" Better tabbing
vnoremap < <gv
vnoremap > >gv

" Better window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap <Leader>o o<Esc>^Da
nnoremap <Leader>O O<Esc>^Da

"--------------------------
" PLUGINS
"--------------------------

call plug#begin('~/local/share/nvim/plugged')
Plug 'folke/tokyonight.nvim'
Plug 'itchyny/lightline.vim'
Plug 'airblade/vim-gitgutter'
Plug 'nvim-treesitter/nvim-treesitter'
call plug#end()

" Coloscheme
let g:tokyonight_style = 'night' " available: night, storm
let g:tokyonight_enable_italic = 1
let g:tokyonight_transparent = 'true'
colorscheme tokyonight

" Lightline
let g:lightline = {'colorscheme': 'tokyonight'}

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
  ignore_install = { "javascript" }, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { "c", "rust" },  -- list of language that will be disabled
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EOF

