-- Keybinds
vim.keymap.set("i", "<C-c>", "<Esc>")

-- File explorer
vim.keymap.set("n", "<leader>pv", ":NvimTreeToggle<CR>")

-- Move selection in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Remain in center screen using Up/Down/Find
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Delete/Paste without copying
vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- Sum all rows in file with :Sum
vim.api.nvim_create_user_command("Sum", ":%!awk '{print; total+=$1}END{print total}'", {})

-- Format file with :Format
vim.api.nvim_create_user_command("Format", ":lua vim.lsp.buf.format({ timeout_ms = 2000 })", {})

-- Execute file with F5
vim.api.nvim_buf_set_keymap(0, "n", "<F5>", ":!chmod +x % && ./%<CR>", vim.opt)
