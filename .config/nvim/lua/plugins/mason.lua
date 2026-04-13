return {
	{ "neovim/nvim-lspconfig" }, -- provides lsp/ runtime configs (cmd, root_dir, etc.)
	{ "williamboman/mason.nvim", config = true },
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"bashls",
					"dockerls",
					"lua_ls",
					"pyright",
					"yamlls",
				},
			})
		end,
	},
}
