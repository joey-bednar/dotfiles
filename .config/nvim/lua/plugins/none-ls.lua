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
				"prettier",
				"shfmt",
				"stylua",
			},
			automatic_installation = false,
			handlers = {
				-- mason-null-ls auto handler breaks mypy config. Keep this function empty.
				mypy = function(_, _) end,
			},
		})

		-- use venv mypy if in a venv
		local function get_venv_path()
			local venv = os.getenv("VIRTUAL_ENV")
			if venv then
				return venv .. "/bin/"
			end
			return ""
		end

		local null_ls = require("null-ls")
		null_ls.setup({
			debug = true,
			sources = {
				-- use shfmt for zsh formatting
				null_ls.builtins.formatting.shfmt.with({
					filetypes = { "sh", "bash", "zsh" },
					args = { "--indent", 4, "--space-redirects", "$FILENAME" },
				}),

				-- use mypy in venv if possible
				null_ls.builtins.diagnostics.mypy.with({
					command = get_venv_path() .. "mypy",
					extra_args = { "--python-executable", get_venv_path() .. "python3" },
				}),
			},
		})
	end,
}
