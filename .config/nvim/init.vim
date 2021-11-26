source $HOME/.config/nvim/general/settings.vim
source $HOME/.config/nvim/keys/mappings.vim

call plug#begin('~/local/share/nvim/plugged')
Plug 'itchyny/lightline.vim'
Plug 'dracula/vim'
Plug 'airblade/vim-gitgutter'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'ray-x/lsp_signature.nvim'
call plug#end()

colorscheme dracula
let g:dracula_colorterm = 0
set background=dark

set laststatus=2
" Lightline
let g:lightline = {}
let g:lightline.colorscheme = "darcula"

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

