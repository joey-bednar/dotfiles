require("mason").setup()
require("mason-null-ls").setup({
	ensure_installed = {
		-- Opt to list sources here, when available in mason.
	},
	automatic_installation = false,
	handlers = {},
})

--local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
require("null-ls").setup({
	sources = {
		-- Anything not supported by mason.
	},
	---- you can reuse a shared lspconfig on_attach callback here
	--on_attach = function(client, bufnr)
	--if client.supports_method("textDocument/formatting") then
	--vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
	--vim.api.nvim_create_autocmd("BufWritePre", {
	--group = augroup,
	--buffer = bufnr,
	--callback = function()
	---- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
	---- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
	---- vim.lsp.buf.formatting_sync()
	--vim.lsp.buf.format({ async = false })
	--end,
	--})
	--end
	--end,
})
