return {
	"ThePrimeagen/harpoon",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},

	config = function()
		local mark = require("harpoon.mark")
		local ui = require("harpoon.ui")
		local term = require("harpoon.term")

		vim.keymap.set("n", "<leader>a", mark.add_file, { desc = "Harpoon add file." })
		vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu, { desc = "Harpoon menu." })

		vim.keymap.set("n", "<C-h>", function()
			ui.nav_file(1)
		end, { desc = "Harpoon file 1." })
		vim.keymap.set("n", "<C-j>", function()
			ui.nav_file(2)
		end, { desc = "Harpoon file 2." })
		vim.keymap.set("n", "<C-k>", function()
			ui.nav_file(3)
		end, { desc = "Harpoon file 3." })
		vim.keymap.set("n", "<C-l>", function()
			ui.nav_file(4)
		end, { desc = "Harpoon file 4." })
		vim.keymap.set("n", "<leader>t", function()
			term.gotoTerminal(1)
		end, { desc = "Harpoon terminal." })

		vim.api.nvim_set_keymap("t", "<C-d>", [[<C-\><C-n>]], { noremap = true, desc = "Close terminal remap." })
	end,
}
-- TODO: migrate to harpoon2
