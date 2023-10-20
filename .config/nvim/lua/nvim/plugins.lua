-- Only required if you have packer configured as `opt`
vim.cmd.packadd('packer.nvim')

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- Dashboard
    use {
        'glepnir/dashboard-nvim',
        event = 'VimEnter',
        config = function()
            require('dashboard').setup {
                theme = 'hyper',
                config = {
                    week_header = {
                        enable = true,
                    },
                    shortcut = {
                        { desc = ' Update', group = '@property', action = 'PackerSync', key = 'u' },
                        {
                            icon = ' ',
                            icon_hl = '@variable',
                            desc = 'Files',
                            group = 'Label',
                            action = 'Telescope find_files',
                            key = 'f',
                        },
                        {
                            desc = ' dotfiles',
                            group = 'Number',
                            action = 'Telescope find_files search_dirs=~/dotfiles',
                            key = 'd',
                        },
                    },
                    footer = {"What can I do?"},
                    disable_move = true,
                },
                shortcut_type = 'number',
                hide = {
                    statusline = 'true',
                    tabline = 'true',
                },
            }
        end,
        requires = {'nvim-tree/nvim-web-devicons'}
    }

    -- dev icons
    use("nvim-tree/nvim-web-devicons")

    -- status line
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }

    -- telescope
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.x',
        -- or                            , branch = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    use {"nvim-telescope/telescope-fzf-native.nvim", run = "make"}

    -- treesitter
    use({"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"})

    -- file explorer
    use("nvim-tree/nvim-tree.lua")

    -- LSP
    use("neovim/nvim-lspconfig")
    use("williamboman/mason.nvim")
    use("williamboman/mason-lspconfig.nvim")

    -- Linting/Formatting
    use("jose-elias-alvarez/null-ls.nvim")
    use("jay-babu/mason-null-ls.nvim")

    -- CMP
    use("hrsh7th/nvim-cmp")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-path")
    use("hrsh7th/cmp-calc")
    use("hrsh7th/cmp-cmdline")
    use("hrsh7th/cmp-nvim-lsp")
    use("ray-x/cmp-treesitter")

    -- Snippets
    use("hrsh7th/cmp-vsnip")
    use("hrsh7th/vim-vsnip")

    use("nvim-treesitter/nvim-treesitter-context") -- function context
    use("preservim/nerdcommenter") -- commenter
    use("theprimeagen/harpoon") -- harpoon
    use {"windwp/nvim-autopairs"} -- pair quotes/brackets
    use {"windwp/nvim-ts-autotag"} -- pair html tags

    -- markdown preview
    use({
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
    })
    use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install", setup = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" }, })

    -- Themes
    use("navarasu/onedark.nvim")
    use("sainnhe/gruvbox-material")
    use("projekt0n/github-nvim-theme")
end)
