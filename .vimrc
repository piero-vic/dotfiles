" BASIC CONFIG ----------------------------------------------------------- {{{

" Disable Arrow keys in Normal mode
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" Basic configuration
set nocompatible
set backspace=indent,eol,start
set linebreak
filetype on
syntax enable
set number relativenumber
set cursorline

" Tabs
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set autoindent

" AutoCmd
" Vertically center document when entering insert mode
autocmd InsertEnter * norm zz
" Remove trailing whitespaces on save
autocmd BufWritePre * %s/\s\+$//e


" COLORSCHEME ------------------------------------------------------------ {{{

packadd! dracula
colorscheme dracula
let g:dracula_colorterm = 0
set background=dark


" STATUS LINE ------------------------------------------------------------ {{{

" Clear status line when vimrc is reloaded.
set statusline=

" Status line left side.
set statusline+=\ %F\ %M\ %Y\ %R

" Use a divider to separate the left side from the right side.
set statusline+=%=

" Status line right side.
set statusline+=\ ascii:\ %b\ hex:\ 0x%B\ row:\ %l\ col:\ %c\ percent:\ %p%%

" Show the status on the second to last line.
set laststatus=2
