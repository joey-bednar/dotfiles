local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

	{
		"sainnhe/gruvbox-material",
		priority = 1000,
		lazy = false,
		config = function()
			vim.g.gruvbox_material_background = "hard" -- hard, soft, medium
			vim.g.gruvbox_material_foreground = "material" -- original, mix, material
			vim.g.gruvbox_material_enable_italic = 1
			vim.g.gruvbox_material_sign_column_background = "none"

			local grpid = vim.api.nvim_create_augroup("custom_highlights_gruvboxmaterial", {})
			vim.api.nvim_create_autocmd("ColorScheme", {
				group = grpid,
				pattern = "gruvbox-material",
				command = "hi NvimTreeNormal                     guibg=#181818 |"
					.. "hi NvimTreeEndOfBuffer                guibg=#181818 |"
					.. "hi NoiceCmdlinePopupBorderCmdline     guifg=#ea6962 guibg=#282828 |"
					.. "hi TelescopePromptBorder              guifg=#ea6962 guibg=#282828 |"
					.. "hi TelescopePromptNormal              guifg=#ea6962 guibg=#282828 |"
					.. "hi TelescopePromptTitle               guifg=#ea6962 guibg=#282828 |"
					.. "hi TelescopePromptPrefix              guifg=#ea6962 guibg=#282828 |"
					.. "hi TelescopePromptCounter             guifg=#ea6962 guibg=#282828 |"
					.. "hi TelescopePreviewTitle              guifg=#89b482 guibg=#282828 |"
					.. "hi TelescopePreviewBorder             guifg=#89b482 guibg=#282828 |"
					.. "hi TelescopeResultsTitle              guifg=#89b482 guibg=#282828 |"
					.. "hi TelescopeResultsBorder             guifg=#89b482 guibg=#282828 |"
					.. "hi TelescopeMatching                  guifg=#d8a657 guibg=#282828 |"
					.. "hi TelescopeSelection                 guifg=#ffffff guibg=#32302f |"
					.. "hi FloatBorder                        guifg=#ea6962 guibg=#282828 |"
					.. "hi BqfPreviewBorder                   guifg=#ea6962 guibg=#282828 |"
					.. "hi NormalFloat                        guibg=#282828 |"
					.. "hi IndentBlanklineContextChar         guifg=#d3869b |"
					.. "hi StatusColumnBorder                 guifg=#232323 |"
					.. "hi StatusColumnBuffer                 guibg=#282828 |"
					.. "hi CursorLineNr                       guifg=#d8a657 |"
					.. "hi CodewindowBorder                   guifg=#ea6962 |"
					.. "hi TabLine                            guibg=#282828 |",
			})
			vim.cmd("colorscheme gruvbox-material")
		end,
	},
	{
		-- LSP Configuration & Plugins
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Automatically install LSPs to stdpath for neovim
			{ "williamboman/mason.nvim", config = true },
			"williamboman/mason-lspconfig.nvim",

			-- Useful status updates for LSP
			-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
			-- { 'j-hui/fidget.nvim', opts = {} },

			-- Additional lua configuration, makes nvim stuff amazing!
			"folke/neodev.nvim",
		},
	},
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"nvimtools/none-ls.nvim",
		},
	},

	{
		-- Autocompletion
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			-- Snippet Engine & its associated nvim-cmp source
			--"L3MON4D3/LuaSnip",
			--"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-vsnip",
			"hrsh7th/vim-vsnip",

			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-calc",
			"hrsh7th/cmp-cmdline",

			-- Adds LSP completion capabilities
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",

			-- Adds a number of user-friendly snippets
			-- 'rafamadriz/friendly-snippets',
		},
	},

	{
		-- Harpoon
		"ThePrimeagen/harpoon",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},

	{ "nvim-tree/nvim-web-devicons", lazy = true },

	{
		-- Set lualine as statusline
		"nvim-lualine/lualine.nvim",
		-- See `:help lualine.txt`
		opts = {
			options = {
				icons_enabled = true,
				theme = "auto",
				component_separators = "|",
				section_separators = "",
			},
		},
	},
	-- Fuzzy Finder (files, lsp, etc)
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			-- Fuzzy Finder Algorithm which requires local dependencies to be built.
			-- Only load if `make` is available. Make sure you have the system
			-- requirements installed.
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				-- NOTE: If you are having trouble with this installation,
				--       refer to the README for telescope-fzf-native for more instructions.
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
		},
	},

	{
		-- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"nvim-treesitter/nvim-treesitter-context",
		},
		build = ":TSUpdate",
	},

	-- Filetree
	{ "nvim-tree/nvim-tree.lua", lazy = true },
	-- Pair quotes/brackets
	{ "windwp/nvim-autopairs", lazy = true },
	-- Pair html tags
	{ "windwp/nvim-ts-autotag", lazy = true },

}, {})
