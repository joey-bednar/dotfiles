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
		event = { "InsertEnter" },
		lazy = true,
		config = true,
	},
	-- auto tab sizing
	{ "tpope/vim-sleuth" },
}
