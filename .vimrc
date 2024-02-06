" Persistent Undo
set nobackup
set noswapfile
set undodir="~/.vim/undodir"
set undofile

" Interaction
let mapleader=" "
let maplocalleader=" "
set mouse="a"
set clipboard="unnamedplus"

" Line Behavior
set nowrap
set cursorline
set scrolloff=8

" Display
set number
set rnu
"vim.opt.termguicolors = true

" remove line numbers in terminal
autocmd TerminalOpen * setlocal nonumber norelativenumber

" Search
set hls
set incsearch

"-- Windowing
set splitbelow " split screen below or to right of current
set splitright

" Tabs
set tabstop=4 " number of spaces for tabs
set softtabstop=4
set shiftwidth=4 " number of spaces for indentation
set expandtab " transform tabs to spaces
set smartindent
set autoindent " take indent for new line from previous line

" Theme
syntax on
colorscheme slate

" Remaps

" Use Ctrl-c for Esc
inoremap <C-c> <Esc>

" Netrw
nnoremap <leader>pv :Ex<CR>
nnoremap <C-l> :noh<CR>

" Drag selection
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '>-2<CR>gv=gv

" Keep cursor centered using Up/Down/Find
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap n nzzzv 
nnoremap N Nzzzv 

" Paste without yank
vnoremap <leader>p "_dP

" Delete without yank
nnoremap <leader>d "_d
vnoremap <leader>d "_d
