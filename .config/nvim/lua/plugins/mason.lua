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
				-- jdtls is started manually by nvim-jdtls (per-project workspace dir),
				-- so don't let mason-lspconfig auto vim.lsp.enable() it too
				automatic_enable = { exclude = { "jdtls" } },
			})
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require("mason-tool-installer").setup({
				ensure_installed = {
					"prettier",
					"shfmt",
					"stylua",
					"mypy",
					"jdtls",
				},
			})
		end,
	},
}
