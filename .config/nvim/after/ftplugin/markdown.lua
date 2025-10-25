-- Open preview of markdown file with F7
vim.api.nvim_buf_set_keymap(0, "n", "<F7>", ":MarkdownPreview<CR>", { desc = "Preview markdown file." })
vim.api.nvim_buf_set_keymap(0, "i", "<F7>", "<Esc>:MarkdownPreview<CR>", { desc = "Preview markdown file." })
