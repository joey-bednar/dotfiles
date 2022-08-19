" Options
set nobackup "no file backups
set nowritebackup
set ttimeoutlen=0 "time to run commands
set hidden "hide unused buffers
set encoding=UTF-8

" Vim Plugins
call plug#begin()

    Plug 'vim-airline/vim-airline' "fancy title tab bar
    Plug 'https://github.com/preservim/nerdtree' " NerdTree
    Plug 'https://github.com/preservim/tagbar' " Tagbar for code navigation
    Plug 'sonph/onehalf', { 'rtp': 'vim' } "color theme
    Plug 'neoclide/coc.nvim', {'branch': 'release'} " Auto Completion
    ":CocInstall coc-pyright
    ":CocInstall coc-clangd
    ":CocCommand clangd.install

call plug#end()

" Autocompletion
set completeopt=noinsert,menuone,noselect
set wildmode=longest,list,full "suggest files to open
set wildmenu

filetype plugin indent on " automatic syntax support for open files

" Visual
set nowrap "text does not wrap
set background=dark "apply color set for dark screens
set title "show file title
syntax on " syntax highlighting on
set t_Co=256 " used full color range
set cursorline " highlight cursor line
colorscheme onehalfdark "set color theme
let g:airline_theme='onehalfdark'
" lightline
" let g:lightline = { 'colorscheme': 'onehalfdark' }

" match neovim theme to terminal theme
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

" toggle NERDTree with ctrl-t
nnoremap <C-t> :NERDTreeToggle<CR>

" toggle tagbar with F8
nmap <F8> :TagbarToggle<CR>

" enter to autocomplete, tab and shift-tab to move up and down
inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"

"autocmd Filetype java   nnoremap <buffer> <F5> :update<Bar>execute '!javac '.shellescape(@%, 1)<CR>
"autocmd Filetype c,cpp  inoremap <buffer> <F5> <C-o>:update<Bar>execute '!make '.shellescape(expand('%:r'), 1)<CR>
"autocmd Filetype c,cpp  nnoremap <buffer> <F5> :update<Bar>execute '!make '.shellescape(expand('%:r'), 1)<CR>

