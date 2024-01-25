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
