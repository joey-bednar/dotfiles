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
					"cssls",
					"dockerls",
					"helm_ls",
					"html",
					"lua_ls",
					"pyright",
					"yamlls",
				},
				-- Superseded by tsgo (github.com/microsoft/typescript-go), enabled in lsp.lua.
				-- Excluded (not just dropped from ensure_installed) because mason-lspconfig
				-- auto-enables every installed package, not just ones in this list.
				automatic_enable = { exclude = { "ts_ls" } },
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
				},
			})
		end,
	},
}
