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
				"ansible-lint",
				"black",
				"clang-format",
				"prettier",
				"pylint",
				"selene",
				"shfmt",
				"stylua",
			},
			automatic_installation = false,
			handlers = {},
		})

		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				-- use shfmt for zsh formatting
				null_ls.builtins.formatting.shfmt.with({
					filetypes = { "bash", "zsh" },
				}),
			},
		})
	end,
}
