-- Keybinds

-- <C-c> map to <Esc>/:noh
vim.keymap.set("i", "<C-c>", "<Esc>", { desc = "Map <Esc> to <C-c>" })
vim.keymap.set("n", "<C-c>", function()
	vim.cmd.noh()
end, { desc = "Clear highlights" })

-- File explorer
vim.keymap.set("n", "<leader>pv", "<cmd>NvimTreeToggle<CR>", { desc = "NvimTree toggle." })

-- Remain in center screen using Up/Down/Find
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Move down half page." })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Move up half page." })
vim.keymap.set("n", "n", "nzzzv", { desc = "Move to next search." })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Move to previous search." })

-- Delete/Paste without copying
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste over selection without yank." })
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete without yank." })

vim.api.nvim_create_user_command(
	"Sum",
	":%!awk '{print; total+=$1}END{print total}'",
	{ desc = "Sum all rows in buffer." }
)

-- Format file with :Format or <leader>lf
vim.api.nvim_create_user_command(
	"Format",
	":lua vim.lsp.buf.format({ timeout_ms = 2000 })",
	{ desc = "LSP format buffer." }
)
vim.keymap.set("n", "<leader>lf", "<cmd>Format<CR>", { desc = "LSP format buffer." })

-- Execute file with F5
vim.api.nvim_buf_set_keymap(0, "n", "<F5>", ":!chmod +x % && ./%<CR>", { desc = "Execute file." })

-- Git conflicts
vim.keymap.set("n", "<leader>gd", "<cmd>Gvdiffsplit!<CR>", { desc = "Fugitive git diff split." })
vim.keymap.set("n", "gh", "<cmd>diffget //2<CR>", { desc = "Fugitive select left diff." })
vim.keymap.set("n", "gl", "<cmd>diffget //3<CR>", { desc = "Fugitive select right diff." })

-- Git fugitive
vim.keymap.set("n", "<leader>gs", "<cmd>G<CR>", { desc = "Fugitive menu." })
vim.keymap.set("n", "<leader>gb", "<cmd>Git blame<CR>", { desc = "Fugitive git blame." })

-- TODO: look into system/nvim yank/paste on VM
-- TODO: resize splits keymap
