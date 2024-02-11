return {
	-- Filetree
	"nvim-tree/nvim-tree.lua",
	lazy = true,
	cmd = { "NvimTreeToggle" },

	config = function()
		-- disable netrw at the very start of your init.lua
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		-- empty setup using defaults
		require("nvim-tree").setup()

		-- OR setup with some options
		require("nvim-tree").setup({
			sort_by = "case_sensitive",
			view = {
				width = 30,
				number = true,
				relativenumber = true,
			},
			renderer = {
				group_empty = true,
			},
			filters = {
				dotfiles = false,
			},
		})
	end,
}
