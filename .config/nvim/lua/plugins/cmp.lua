return {
	-- Autocompletion
	"hrsh7th/nvim-cmp",
	lazy = true,
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

		-- TODO: switch to luasnip and add ctrl-k keybind

		-- Adds a number of user-friendly snippets
		-- 'rafamadriz/friendly-snippets',
	},

	config = function()
		local cmp = require("cmp")

		local cmp_kinds = {
			Text = "  ",
			Method = "󰡱  ",
			Function = "󰡱  ",
			Constructor = "󰡱  ",
			Field = "  ",
			Variable = "󰫧  ",
			Class = "󰠱  ",
			Interface = "󰠱  ",
			Module = "󰠱  ",
			Property = "  ",
			Unit = "󰆧  ",
			Value = "  ",
			Enum = "  ",
			Keyword = "  ",
			Snippet = "  ",
			Color = "  ",
			File = "  ",
			Reference = "  ",
			Folder = "  ",
			EnumMember = "  ",
			Constant = "  ",
			Struct = "  ",
			Event = "  ",
			Operator = "  ",
			TypeParameter = "  ",
		}

		cmp.setup({
			snippet = {
				-- REQUIRED - you must specify a snippet engine
				expand = function(args)
					vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
					--require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
				end,
			},
			window = {
				completion = cmp.config.window.bordered(),
				-- documentation = cmp.config.window.bordered(),
			},
			mapping = cmp.mapping.preset.insert({
				["<C-k>"] = cmp.mapping.select_prev_item(),
				["<C-j>"] = cmp.mapping.select_next_item(),
				["<C-p>"] = cmp.config.disable,
				["<C-n>"] = cmp.config.disable,

				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),

				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),
				["<C-y>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				--{ name = 'luasnip' }, -- For luasnip users.
				{ name = "vsnip" }, -- For vsnip users.
				{ name = "path" },
				{ name = "calc" },
				{ name = "treesitter" },
			}, {
				{ name = "buffer" },
			}),
			formatting = {
				format = function(_, vim_item)
					vim_item.kind = (cmp_kinds[vim_item.kind] or "") .. vim_item.kind
					return vim_item
				end,
			},
		})

		-- `/` cmdline setup.
		cmp.setup.cmdline("/", {
			mapping = cmp.mapping.preset.cmdline({
				["<C-p>"] = cmp.config.disable,
				["<C-n>"] = cmp.config.disable,
			}),
			sources = {
				{ name = "buffer" },
			},
		})

		-- `:` cmdline setup.
		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline({
				["<C-p>"] = cmp.config.disable,
				["<C-n>"] = cmp.config.disable,
			}),
			sources = cmp.config.sources({
				{ name = "path" },
			}, {
				{
					name = "cmdline",
					option = {
						ignore_cmds = { "Man", "!" },
					},
				},
			}),
		})
	end,
}
