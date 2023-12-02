" line navigation
set scrolloff=8
set number
set rnu

"tabs
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smartindent

"highlighting
set hls
set incsearch

"theme
syntax on
colorscheme default
"hi Normal ctermbg=black
"hi NonText ctermbg=NONE

"remaps
let mapleader = " "
inoremap <C-c> <Esc>
nnoremap <leader>pv :Ex<CR>
nnoremap <C-l> :noh<CR>
