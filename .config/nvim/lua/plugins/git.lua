return {
	"tpope/vim-fugitive",
	config = function()
		-- Git conflicts
		vim.keymap.set("n", "<leader>gd", "<cmd>Gvdiffsplit!<CR>", { desc = "Fugitive git diff split." })
		vim.keymap.set("n", "gh", "<cmd>diffget //2<CR>", { desc = "Fugitive select left diff." })
		vim.keymap.set("n", "gl", "<cmd>diffget //3<CR>", { desc = "Fugitive select right diff." })

		-- Git commands
		vim.keymap.set("n", "<leader>gs", "<cmd>G<CR>", { desc = "Fugitive menu." })
		vim.keymap.set("n", "<leader>gb", "<cmd>Git blame<CR>", { desc = "Fugitive git blame." })
		vim.keymap.set("n", "<leader>gP", "<cmd>Git push<CR>", { desc = "Fugitive git push." })
		vim.keymap.set(
			"n",
			"<leader>gl",
			"<cmd>Git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)' --all<CR>",
			{ desc = "Fugitive git push." }
		)
	end,
}
