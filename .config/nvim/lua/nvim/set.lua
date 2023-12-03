-- General
vim.cmd 'filetype plugin on' -- used for commenting plugin

-- Persistent Undo
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- Interaction
vim.g.mapleader = " "
vim.opt.mouse = "a"
vim.opt.clipboard= "unnamedplus"

-- Line Behavior
vim.opt.wrap = false
vim.opt.cursorline = true
vim.opt.scrolloff = 8

-- Display
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.cmd 'autocmd TermOpen * setlocal nonumber norelativenumber' --remove line numbers in terminal

-- Search
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Windowing
vim.opt.splitbelow = true -- split screen below or to right of current
vim.opt.splitright = true

-- Indents
vim.opt.smartindent = false -- fixes commenting indentation errors
vim.opt.autoindent = true -- turn on autoindentation

-- Tabs
vim.opt.expandtab = true -- transform tabs to spaces
vim.opt.shiftwidth = 4 -- number of spaces for indentation
vim.opt.tabstop = 4 -- number of spaces for tabs
vim.opt.softtabstop = 4

-- Autocompletion
vim.opt.completeopt = "menu,menuone,noselect"

local function isempty(s)
    return s == nil or s == ""
end

-- custom python provider
local conda_prefix = os.getenv("CONDA_PREFIX")
if not isempty(conda_prefix) then
    vim.g.python_host_prog = conda_prefix .. "/bin/python"
    vim.g.python3_host_prog = conda_prefix .. "/bin/python3"
else
    vim.g.python_host_prog = "python"
    vim.g.python3_host_prog = "python3"
end
