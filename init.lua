require('nvim.set')
require('nvim.plugins')
require('nvim.keymaps')
require('nvim.theme')
require('nvim.lualine')
require('nvim.treesitter')

local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
  'pyright',
  'clangd',
  'dockerls',
  'sumneko_lua',
})

-- Fix Undefined global 'vim'
lsp.configure('sumneko_lua', {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
})

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-k>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-j>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  ["<C-Space>"] = cmp.mapping.complete(),
})

cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})

--lsp.set_preferences({
    --suggest_lsp_servers = false,
    --sign_icons = {
        --error = '✗',
        --warn = '✗',
        --hint = '✗',
        --info = '✗'
    --}
--})


lsp.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, remap = false}

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  --vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  --vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  --vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
  --vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

lsp.setup()

local signs = { Error = "✗", Warn = "✗", Hint = "✗", Info = "✗" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
    virtual_text = true
})

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

---- Set up lspconfig.
--local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

---- LSP keymaps
--local on_attach = function()
    --vim.keymap.set("n","K", vim.lsp.buf.hover, {buffer=0}) -- manual entry
    --vim.api.nvim_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", { noremap = true })
    --vim.keymap.set("n","gd", vim.lsp.buf.definition, {buffer=0}) -- jump to definition, ctrl-t to jump back 
    --vim.keymap.set("n","gt", vim.lsp.buf.type_definition, {buffer=0}) -- jump to type definition, ctrl-t to jump back 
    --vim.keymap.set("n","[d", vim.diagnostic.goto_next, {buffer=0}) -- jump to forward error
    --vim.keymap.set("n","]d", vim.diagnostic.goto_prev, {buffer=0}) -- jump to back error
--end

---- Python3
--require'lspconfig'.pyright.setup{
    --capabilities = capabilities,
    --on_attach = on_attach,

    ----turn off type checking in python
    --settings = {
        --python = {
            --analysis = {
                --typeCheckingMode = "off"
            --}
        --}
    --}

--}

---- Set up nvim-cmp.
--local cmp = require'cmp'

--cmp.setup({
    --snippet = {
        --expand = function(args)
            --require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        --end,
    --},
    --window = {
        --completion = cmp.config.window.bordered(),
        ----documentation = cmp.config.window.bordered(),
    --},
    --mapping = cmp.mapping.preset.insert({
        --['<C-k>'] = cmp.mapping.select_prev_item(),
        --['<C-j>'] = cmp.mapping.select_next_item(),
        --['<C-b>'] = cmp.mapping.scroll_docs(-4),
        --['<C-f>'] = cmp.mapping.scroll_docs(4),
        --['<C-Space>'] = cmp.mapping.complete(),
        --['<C-e>'] = cmp.mapping.abort(),
        --['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    --}),
    --sources = cmp.config.sources({
        --{ name = 'nvim_lsp' },
        --{ name = 'luasnip' }, -- For luasnip users.
    --}, {
        --{ name = 'buffer' },
    --})
--})

---- Set configuration for specific filetype.
--cmp.setup.filetype('gitcommit', {
    --sources = cmp.config.sources({
        --{ name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    --}, {
        --{ name = 'buffer' },
    --})
--})


