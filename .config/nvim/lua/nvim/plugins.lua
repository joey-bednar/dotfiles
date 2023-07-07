-- Only required if you have packer configured as `opt`
--vim.cmd.packadd('packer.nvim')

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- status line
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }

    -- telescope
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        -- or                            , branch = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    -- treesitter
    use({"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"})

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
    use("hrsh7th/cmp-nvim-lsp")

    -- Snippets
    use("saadparwaiz1/cmp_luasnip")
    use("L3MON4D3/LuaSnip")

    use("preservim/nerdcommenter") -- commenter
    use("navarasu/onedark.nvim") -- theme
    use("theprimeagen/harpoon") -- harpoon

end)
