return {
	"glepnir/dashboard-nvim",
	event = "VimEnter",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("dashboard").setup({
			theme = "hyper",
			config = {
				week_header = {
					enable = true,
				},
				shortcut = {
					{ desc = " Update", group = "@property", action = "PackerSync", key = "u" },
					{
						icon = " ",
						icon_hl = "@variable",
						desc = "Files",
						group = "Label",
						action = "Telescope find_files",
						key = "f",
					},
					{
						desc = " dotfiles",
						group = "Number",
						action = "Telescope find_files search_dirs=~/dotfiles",
						key = "d",
					},
				},
				footer = { "What can I do?" },
				disable_move = true,
			},
			shortcut_type = "number",
			hide = {
				statusline = "true",
				tabline = "true",
			},
		})
	end,
}
