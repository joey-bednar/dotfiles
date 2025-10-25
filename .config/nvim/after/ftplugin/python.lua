-- Run python files with F7
vim.api.nvim_buf_set_keymap(
	0,
	"n",
	"<F7>",
	":update<Bar>execute '!python3 '.shellescape(@%, 1)<CR>",
	{ desc = "Run python file." }
)
vim.api.nvim_buf_set_keymap(
	0,
	"i",
	"<F7>",
	"<C-o>:update<Bar>execute '!python3 '.shellescape(@%, 1)<CR>",
	{ desc = "Run python file." }
)
