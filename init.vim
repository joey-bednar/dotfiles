" Options
set background=dark "apply color set for dark screens
set title "show file title
set ttimeoutlen=0 "time to run commands
set hidden "hide unused buffers
set nowrap "text does not wrap

" Vim Plugins
call plug#begin()
    Plug 'vim-airline/vim-airline' "fancy title tab bar
    Plug 'sonph/onehalf', { 'rtp': 'vim' } "color theme
call plug#end()

" Autocompletion
set completeopt=noinsert,menuone,noselect
set wildmode=longest,list,full "suggest files to open
set wildmenu

filetype plugin indent on " automatic syntax support for open files

" Visual
syntax on " syntax highlighting on
set t_Co=256 " used full color range
set cursorline " highlight cursor line
colorscheme onehalfdark "set color theme
let g:airline_theme='onehalfdark'
" lightline
" let g:lightline = { 'colorscheme': 'onehalfdark' }

" match terminal theme to neovim theme
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif


" Navigation
set mouse=a "allow mouse in nvim
set clipboard=unnamedplus "enable clipboard between other applications
set number "show line numbers
autocmd TermOpen * setlocal nonumber norelativenumber "remove line numbers in terminal

" Tabs
set autoindent " turn on autoindentation
set expandtab "transform tabs to spaces
set shiftwidth=2 "number of spaces for indentation
set tabstop=2 "number of spaces for tabs

" Windowing
set splitbelow splitright "screens split below and to right of current

" Shortcuts

" run python3 file with F5
autocmd Filetype python inoremap <buffer> <F5> <C-o>:update<Bar>execute '!python3 '.shellescape(@%, 1)<CR>
autocmd Filetype python nnoremap <buffer> <F5> :update<Bar>execute '!python3 '.shellescape(@%, 1)<CR>

"autocmd Filetype java   inoremap <buffer> <F5> <C-o>:update<Bar>execute '!javac '.shellescape(@%, 1)<CR>
"autocmd Filetype java   nnoremap <buffer> <F5> :update<Bar>execute '!javac '.shellescape(@%, 1)<CR>

"autocmd Filetype c,cpp  inoremap <buffer> <F5> <C-o>:update<Bar>execute '!make '.shellescape(expand('%:r'), 1)<CR>
"autocmd Filetype c,cpp  nnoremap <buffer> <F5> :update<Bar>execute '!make '.shellescape(expand('%:r'), 1)<CR>


