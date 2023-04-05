require('nvim.set')
require('nvim.plugins')
require('nvim.keymaps')
require('nvim.theme')
require('nvim.lualine')
require('nvim.treesitter')

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

local lspconfig = require('lspconfig')

require('mason-lspconfig').setup_handlers({
  function(server)
    lspconfig[server].setup({})
  end,
})

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- LSP keymaps
local on_attach = function()
    vim.keymap.set("n","K", vim.lsp.buf.hover, {buffer=0}) -- manual entry
    vim.api.nvim_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", { noremap = true })
    vim.keymap.set("n","gd", vim.lsp.buf.definition, {buffer=0}) -- jump to definition, ctrl-t to jump back 
    vim.keymap.set("n","gt", vim.lsp.buf.type_definition, {buffer=0}) -- jump to type definition, ctrl-t to jump back 
    vim.keymap.set("n","[d", vim.diagnostic.goto_next, {buffer=0}) -- jump to forward error
    vim.keymap.set("n","]d", vim.diagnostic.goto_prev, {buffer=0}) -- jump to back error
end

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


