-- Compile/Run Go files with F7
vim.api.nvim_buf_set_keymap(
	0,
	"n",
	"<F7>",
	":update<Bar>execute '!go run '.shellescape(@%, 1)<CR>",
	{ desc = "Compile/run Go file." }
)
vim.api.nvim_buf_set_keymap(
	0,
	"i",
	"<F7>",
	"<C-o>:update<Bar>execute '!go run '.shellescape(@%, 1)<CR>",
	{ desc = "Compile/run Go file." }
)
