return {
	{
		-- add background highlight to RGB values
		"NvChad/nvim-colorizer.lua",
		lazy = true,
		event = { "BufReadPre", "BufNewFile" },
		opts = {},
	},
	{
		-- pair quotes/brackets
		"windwp/nvim-autopairs",
		lazy = true,
		event = { "BufReadPre", "BufNewFile" },
	},
	{
		-- close html tags
		"windwp/nvim-ts-autotag",
		lazy = true,
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"hrsh7th/nvim-cmp",
		},

		config = function()
			local autopairs = require("nvim-autopairs")
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			local cmp = require("cmp")

			autopairs.setup({
				disable_filetype = { "TelescopePrompt", "vim" },
			})

			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

			require("nvim-treesitter.configs").setup({
				autotag = {
					enable = true,
				},
			})
		end,
	},

	-- auto tab sizing
	{ "tpope/vim-sleuth" },
}
