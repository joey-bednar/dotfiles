return {
		"ThePrimeagen/harpoon",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},









    config = function()

local mark = require("harpoon.mark")
local ui = require("harpoon.ui")
local term = require("harpoon.term")

vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

vim.keymap.set("n", "<leader>h", function()
	ui.nav_file(1)
end)
vim.keymap.set("n", "<leader>j", function()
	ui.nav_file(2)
end)
vim.keymap.set("n", "<leader>k", function()
	ui.nav_file(3)
end)
vim.keymap.set("n", "<leader>l", function()
	ui.nav_file(4)
end)
vim.keymap.set("n", "<leader>t", function()
	term.gotoTerminal(1)
end)

vim.api.nvim_set_keymap("t", "<C-d>", [[<C-\><C-n>]], { noremap = true })
    end
}
