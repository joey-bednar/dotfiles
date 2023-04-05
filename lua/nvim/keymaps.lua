-- Keybinds

-- fix Ctrl-c linting issue
vim.keymap.set('i', '<C-c>', '<Esc>')

-- Run python files with F5
vim.api.nvim_create_autocmd("FileType", { pattern = "python", callback = function()
    vim.api.nvim_buf_set_keymap(0,"n","<F5>",":update<Bar>execute '!python3 '.shellescape(@%, 1)<CR>",vim.opt)
    vim.api.nvim_buf_set_keymap(0,"i","<F5>","<C-o>:update<Bar>execute '!python3 '.shellescape(@%, 1)<CR>",vim.opt)
end})

-- Compile and run C files with F5
-- Make with F6
vim.api.nvim_create_autocmd("FileType", { pattern = "c", callback = function()
    vim.api.nvim_buf_set_keymap(0,"n","<F5>",":w<CR>:!gcc -o %< % && ./%< <CR>",vim.opt)
    vim.api.nvim_buf_set_keymap(0,"i","<F5>","<Esc>:w<CR>:!gcc -o %< % && ./%< <CR>",vim.opt)

    local c_project_dir = os.getenv("HOME") .. "/Documents/Code/chess"
    vim.api.nvim_buf_set_keymap(0,"n","<F6>","<Esc>:w<CR>:!(cd " .. c_project_dir .. " && make)<CR>",vim.opt)
    vim.api.nvim_buf_set_keymap(0,"i","<F6>",":w<CR>:!(cd " .. c_project_dir .. " && make)<CR>",vim.opt)
end})


-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.git_files, {})
vim.keymap.set('n', '<leader>fs', builtin.live_grep, {})

