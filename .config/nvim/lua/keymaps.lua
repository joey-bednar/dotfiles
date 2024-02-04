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

-- Run python files with F5
vim.api.nvim_create_autocmd("FileType", {
	pattern = "python",
	callback = function()
		vim.api.nvim_buf_set_keymap(0, "n", "<F5>", ":update<Bar>execute '!python3 '.shellescape(@%, 1)<CR>", vim.opt)
		vim.api.nvim_buf_set_keymap(
			0,
			"i",
			"<F5>",
			"<C-o>:update<Bar>execute '!python3 '.shellescape(@%, 1)<CR>",
			vim.opt
		)
	end,
})

-- Compile and run C files with F5
-- Make with F6
-- Run project with F7
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "c", "make", "cpp" },
	callback = function()
		vim.api.nvim_buf_set_keymap(0, "n", "<F5>", ":w<CR>:!gcc -o %< % && ./%< <CR>", vim.opt)
		vim.api.nvim_buf_set_keymap(0, "i", "<F5>", "<Esc>:w<CR>:!gcc -o %< % && ./%< <CR>", vim.opt)

		local c_project_dir = os.getenv("HOME") .. "/Documents/Code/chess"
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
	end,
})

-- Open preview of markdown file with F5
vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		vim.api.nvim_buf_set_keymap(0, "n", "<F5>", ":MarkdownPreview<CR>", vim.opt)
		vim.api.nvim_buf_set_keymap(0, "i", "<F5>", "<Esc>:MarkdownPreview<CR>", vim.opt)
	end,
})
