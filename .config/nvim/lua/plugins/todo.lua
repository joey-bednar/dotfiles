return {
	{
		"folke/todo-comments.nvim",
		lazy = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		event = "VimEnter",
		config = function()
			-- this is the same as using opts {}
			require("todo-comments.config").setup({
				search = {
					args = {
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--hidden",
					},
				},
			})

			-- search todos keymap
			vim.keymap.set("n", "<leader>ft", ":TodoTelescope keywords=TODO<CR>")
		end,
	},
}
