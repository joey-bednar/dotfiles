vim.api.nvim_buf_set_keymap(0, "n", "<F5>", ":w<CR>:luafile %<CR>", { desc = "Run lua file." })
vim.api.nvim_buf_set_keymap(0, "i", "<F5>", "<Esc>:w<CR>:luafile %<CR>", { desc = "Run lua file." })
