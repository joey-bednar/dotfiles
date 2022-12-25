-- match neovim theme to Gnome Terminal theme 

--if exists('+termguicolors')
  --let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  --let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  --set termguicolors
--endif

-- Plugins
vim.cmd[[
call plug#begin()

    " Status Line
    Plug 'nvim-lualine/lualine.nvim'
    Plug 'kyazdani42/nvim-web-devicons'

    " LSP
    Plug 'neovim/nvim-lspconfig'
    Plug 'williamboman/mason.nvim'
    Plug 'williamboman/mason-lspconfig.nvim'

    " Theme
    Plug 'navarasu/onedark.nvim'

    " Commenting Shortcut
    Plug 'preservim/nerdcommenter'

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

    " Highlighting
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
call plug#end()
]]


-- Keybinds

-- fix Ctrl-c linting issue
vim.keymap.set('i', '<C-c>', '<Esc>')

-- Run python3 and c files with F5
vim.cmd [[
autocmd Filetype python inoremap <buffer> <F5> <C-o>:update<Bar>execute '!python3 '.shellescape(@%, 1)<CR>
autocmd Filetype python nnoremap <buffer> <F5> :update<Bar>execute '!python3 '.shellescape(@%, 1)<CR>

"autocmd FileType c inoremap <buffer> <F5> <Esc>:w<CR>:!gcc -o %< % && ./%< <CR>
"autocmd FileType c nnoremap <buffer> <F5> :w<CR>:!gcc -o %< % && ./%< <CR>
autocmd FileType c inoremap <buffer> <F5> <Esc>:w<CR>:!gcc -o %< % && %< <CR>
autocmd FileType c nnoremap <buffer> <F5> :w<CR>:!gcc -o %< % && %< <CR>
]]

-- General
-- vim.opt.nobackup = true
vim.cmd 'filetype plugin on' -- used for commenting plugin
vim.opt.writebackup = false
vim.opt.ttimeoutlen = 0
vim.opt.hidden = true
vim.g.mapleader = " "
vim.opt.encoding = "utf-8"

-- Navigation
vim.opt.mouse = "a"
vim.opt.clipboard= "unnamedplus"
vim.opt.number = true
vim.opt.relativenumber = true
vim.cmd 'autocmd TermOpen * setlocal nonumber norelativenumber' --remove line numbers in terminal

-- Visual
vim.opt.wrap = false
vim.opt.cursorline = true
vim.opt.background = "dark"

-- Theme
require('onedark').setup  {
    -- Main options --
    style = 'darker', -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
    transparent = true,  -- Show/hide background
    term_colors = true, -- Change terminal color as per the selected theme style
    ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
    cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

    -- toggle theme style ---
    toggle_style_key = nil, -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
    toggle_style_list = {'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light'}, -- List of styles to toggle between

    -- Change code style ---
    -- Options are italic, bold, underline, none
    -- You can configure multiple style with comma seperated, For e.g., keywords = 'italic,bold'
    code_style = {
        comments = 'italic',
        keywords = 'none',
        functions = 'none',
        strings = 'none',
        variables = 'none'
    },

    -- Lualine options --
    lualine = {
        transparent = true, -- lualine center bar transparency
    },

    -- Custom Highlights --
    colors = {}, -- Override default colors
    highlights = {}, -- Override highlight groups

    -- Plugins Config --
    diagnostics = {
        darker = true, -- darker colors for diagnostic
        undercurl = true,   -- use undercurl instead of underline for diagnostics
        background = true,    -- use background color for virtual text
    },
}
require('onedark').load()

-- Mason
require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

-- Mason LSP Config
require("mason-lspconfig").setup({
    ensure_installed = {"pyright","clangd","dockerls","sumneko_lua"},
    automatic_installation = false,
})

-- Lualine
require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = 'onedark',
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        disabled_filetypes = {
            statusline = {},
            winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
        }
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {'filename'},
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
}

-- Windowing
vim.opt.splitbelow = true -- split screen below or to right of current
vim.opt.splitright = true

-- Tabs
vim.opt.autoindent = true -- turn on autoindentation
vim.opt.expandtab = true -- transform tabs to spaces
vim.opt.shiftwidth = 4 -- number of spaces for indentation
vim.opt.tabstop = 4 -- number of spaces for tabs

-- Autocompletion
vim.opt.completeopt = "menu,menuone,noselect"

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- LSP keymaps
local on_attach = function()
    vim.keymap.set("n","K", vim.lsp.buf.hover, {buffer=0}) -- manual entry
    vim.keymap.set("n","gd", vim.lsp.buf.definition, {buffer=0}) -- jump to definition, ctrl-t to jump back 
    vim.keymap.set("n","gt", vim.lsp.buf.type_definition, {buffer=0}) -- jump to type definition, ctrl-t to jump back 
    vim.keymap.set("n","[d", vim.diagnostic.goto_next, {buffer=0}) -- jump to forward error
    vim.keymap.set("n","]d", vim.diagnostic.goto_prev, {buffer=0}) -- jump to back error
end


-- Run sudo npm install -g tree-sitter-cli

-- Python3
require'lspconfig'.pyright.setup{
    capabilities = capabilities,
    on_attach = on_attach,

    --turn off type checking in python
    settings = {
        python = {
            analysis = {
                typeCheckingMode = "off"
            }
        }
    }

}

-- C/C++
require'lspconfig'.clangd.setup{
    capabilities = capabilities,
    on_attach = on_attach,
}

-- Lua
require'lspconfig'.sumneko_lua.setup{
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
}

-- Docker
require'lspconfig'.dockerls.setup{
    capabilities = capabilities,
    on_attach = on_attach,
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
        completion = cmp.config.window.bordered(),
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
    ensure_installed = { "python", "c", "lua", "gitignore", "markdown" },

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


