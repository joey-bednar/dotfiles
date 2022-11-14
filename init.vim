" General
set nobackup "no file backups
set nowritebackup
"set ttimeoutlen=0 "time to run commands
set hidden "hide unused buffers
filetype plugin on "used for commenting plugin
let mapleader = " "
set encoding=UTF-8


" Plugins
call plug#begin()
    Plug 'vim-airline/vim-airline' "Title bar
    Plug 'sonph/onehalf', { 'rtp': 'vim' } "Theme
    Plug 'neovim/nvim-lspconfig' "LSP
    Plug 'preservim/nerdcommenter' "Commenting

    " Autocompletion
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/nvim-cmp'
    
    " Autocomplete Menu
    Plug 'L3MON4D3/LuaSnip'
    Plug 'saadparwaiz1/cmp_luasnip'

    " Telescope
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }

    " TreeSitter highlighting
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
call plug#end()

" Navigation
set mouse=a "use mouse
set clipboard=unnamedplus "use system clipboard
set number "show line numbers
set relativenumber "relative line numbers
autocmd TermOpen * setlocal nonumber norelativenumber "remove line numbers in terminal

" Tabs
set autoindent " turn on autoindentation
set expandtab "transform tabs to spaces
set shiftwidth=4 "number of spaces for indentation
set tabstop=4 "number of spaces for tabs

" Windowing
set splitbelow splitright "screens split below and to right of current

" Visual
set nowrap "text does not wrap
set background=dark "apply color set for dark screens
set cursorline " highlight cursor line

" Theme
set t_Co=256 " use full color range
syntax on " syntax highlighting on

colorscheme onehalfdark "set color theme
hi Normal ctermbg=16 guibg=#000000
hi LineNr ctermbg=16 guibg=#000000
let g:airline_theme='onehalfdark'

" match neovim theme to terminal theme
" if exists('+termguicolors')
  " let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  " let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  " set termguicolors
" endif

" Shortcuts  
" Fix ctrl-c linting issue
inoremap <C-c> <Esc>

" Run python3 with F5
autocmd Filetype python inoremap <buffer> <F5> <C-o>:update<Bar>execute '!python3 '.shellescape(@%, 1)<CR>
autocmd Filetype python nnoremap <buffer> <F5> :update<Bar>execute '!python3 '.shellescape(@%, 1)<CR>


" Autocompletion
"lua require('init')
set completeopt=menu,menuone,noselect


lua <<EOF

-- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

  require'lspconfig'.pyright.setup{
      capabilities = capabilities,
      on_attach = function()
          vim.keymap.set("n","K", vim.lsp.buf.hover, {buffer=0}) -- manual entry
          vim.keymap.set("n","gd", vim.lsp.buf.definition, {buffer=0}) -- jump to definition, ctrl-t to jump back 
          vim.keymap.set("n","gt", vim.lsp.buf.type_definition, {buffer=0}) -- jump to type definition, ctrl-t to jump back 
          vim.keymap.set("n","[d", vim.diagnostic.goto_next, {buffer=0}) -- jump to forward error
          vim.keymap.set("n","]d", vim.diagnostic.goto_prev, {buffer=0}) -- jump to back error
     end,
     --turn off type checking in python
     settings = {
      python = {
        analysis = {
          typeCheckingMode = "off"
        }
      }
    }

  }

  -- Set up nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      end,
    },
    window = {
      --completion = cmp.config.window.bordered(),
      --documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-k>'] = cmp.mapping.select_prev_item(),
      ['<C-j>'] = cmp.mapping.select_next_item(),
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' }, -- For luasnip users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

-- Errors
vim.diagnostic.config({
  virtual_text = true,
})


local signs = { Error = "✗", Warn = "✗", Hint = "✗", Info = "✗" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end


-- TreeSitter Highlighting
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "python", "lua" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (for "all")
  --ignore_install = { "javascript" },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    --disable = { "c", "rust" },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

EOF



