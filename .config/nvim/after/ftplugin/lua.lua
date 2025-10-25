vim.api.nvim_buf_set_keymap(0, "n", "<F7>", ":w<CR>:luafile %<CR>", { desc = "Run lua file." })
vim.api.nvim_buf_set_keymap(0, "i", "<F7>", "<Esc>:w<CR>:luafile %<CR>", { desc = "Run lua file." })
