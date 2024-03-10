return {
	"jay-babu/mason-null-ls.nvim",
	lazy = true,
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"williamboman/mason.nvim",
		"nvimtools/none-ls.nvim",
	},

	config = function()
		require("mason").setup()
		require("mason-null-ls").setup({
			ensure_installed = {
				-- Opt to list sources here, when available in mason.
				"pylint",
				"black",
				"prettier",
				"shfmt",
				"stylua",
			},
			automatic_installation = false,
			handlers = {},
		})

		--local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
		require("null-ls").setup({
			sources = {
				-- Anything not supported by mason.
			},
		})
	end,
}
