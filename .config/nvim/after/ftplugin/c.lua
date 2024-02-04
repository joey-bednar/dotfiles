-- Compile and run C files with F5
-- Make with F6
-- Run project with F7
vim.api.nvim_buf_set_keymap(0, "n", "<F5>", ":w<CR>:!gcc -o %< % && ./%< <CR>", vim.opt)
vim.api.nvim_buf_set_keymap(0, "i", "<F5>", "<Esc>:w<CR>:!gcc -o %< % && ./%< <CR>", vim.opt)

-- TODO: find make file or git repo and run
local c_project_dir = os.getenv("HOME") .. "/personal/chess_old"
local c_project_main = "main"
vim.api.nvim_buf_set_keymap(0, "n", "<F6>", ":w<CR>:!(cd " .. c_project_dir .. " && make)<CR>", vim.opt)
vim.api.nvim_buf_set_keymap(0, "i", "<F6>", "<Esc>:w<CR>:!(cd " .. c_project_dir .. " && make)<CR>", vim.opt)

vim.api.nvim_buf_set_keymap(
	0,
	"n",
	"<F7>",
	":w<CR>:!(cd " .. c_project_dir .. " && ./" .. c_project_main .. ")<CR>",
	vim.opt
)
vim.api.nvim_buf_set_keymap(
	0,
	"i",
	"<F7>",
	"<Esc>:w<CR>:!(cd " .. c_project_dir .. " && ./" .. c_project_main .. ")<CR>",
	vim.opt
)
