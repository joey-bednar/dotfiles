-- Keybinds
vim.keymap.set('i', '<C-c>', '<Esc>')

-- Netrw
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

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
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

-- Run python files with F5
vim.api.nvim_create_autocmd("FileType", { pattern = "python", callback = function()
    vim.api.nvim_buf_set_keymap(0,"n","<F5>",":update<Bar>execute '!python3 '.shellescape(@%, 1)<CR>",vim.opt)
    vim.api.nvim_buf_set_keymap(0,"i","<F5>","<C-o>:update<Bar>execute '!python3 '.shellescape(@%, 1)<CR>",vim.opt)
end})

-- Compile and run C files with F5
-- Make with F6
-- Run project with F7
vim.api.nvim_create_autocmd("FileType", { pattern = {"c","make","cpp"}, callback = function()
    vim.api.nvim_buf_set_keymap(0,"n","<F5>",":w<CR>:!gcc -o %< % && ./%< <CR>",vim.opt)
    vim.api.nvim_buf_set_keymap(0,"i","<F5>","<Esc>:w<CR>:!gcc -o %< % && ./%< <CR>",vim.opt)

    local c_project_dir = os.getenv("HOME") .. "/Documents/Code/chess"
    local c_project_main = "main"
    vim.api.nvim_buf_set_keymap(0,"n","<F6>",":w<CR>:!(cd " .. c_project_dir .. " && make)<CR>",vim.opt)
    vim.api.nvim_buf_set_keymap(0,"i","<F6>","<Esc>:w<CR>:!(cd " .. c_project_dir .. " && make)<CR>",vim.opt)

    vim.api.nvim_buf_set_keymap(0,"n","<F7>",":w<CR>:!(cd " .. c_project_dir .. " && ./" .. c_project_main .. ")<CR>",vim.opt)
    vim.api.nvim_buf_set_keymap(0,"i","<F7>","<Esc>:w<CR>:!(cd " .. c_project_dir .. " && ./" .. c_project_main .. ")<CR>",vim.opt)
end})


-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.git_files, {})
vim.keymap.set('n', '<leader>fs', builtin.live_grep, {})

-- Telescope Menu
local actions = require("telescope.actions")
require("telescope").setup{
  defaults = {
    mappings = {
      i = {
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-j>"] = actions.move_selection_next
      },
    },
  }
}
