-- Open preview of markdown file with F5
vim.api.nvim_buf_set_keymap(0, "n", "<F5>", ":MarkdownPreview<CR>", vim.opt)
vim.api.nvim_buf_set_keymap(0, "i", "<F5>", "<Esc>:MarkdownPreview<CR>", vim.opt)
