local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
  'pyright',
  'clangd',
  'dockerls',
  'lua_ls',
})

-- Fix Undefined global 'vim'
lsp.configure('lua_ls', {
    settings = {
        Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
})

-- Disable Python3 type checking
lsp.configure('pyright', {
    settings = {
        python = {
            analysis = {
                typeCheckingMode = "off"
            }
        }
    }
})

-- Fix keyordering error in YAML
lsp.configure('yamlls', {
    settings = {
        yaml = {
            keyOrdering = false
        }
    }
})

-- Autocompletion Keybinds
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

-- LSP Keybinds
lsp.on_attach(function(_, bufnr)
  local opts = {buffer = bufnr, remap = false}

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>rr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
end)

lsp.setup()

-- Bordered Autocomplete Window
cmp.setup({
    window = {
        completion = cmp.config.window.bordered(),
        --documentation = cmp.config.window.bordered(),
    },
})

-- Error Settings
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
