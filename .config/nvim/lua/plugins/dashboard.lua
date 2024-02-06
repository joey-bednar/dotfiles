return {
	"glepnir/dashboard-nvim",
	event = "VimEnter",
	dependencies = {
		{
			"nvim-tree/nvim-web-devicons",
			config = function()
				require("nvim-web-devicons").setup({

					-- override using icons from:
					-- https://www.nerdfonts.com/cheat-sheet
					-- and defaults from:
					-- https://github.com/nvim-tree/nvim-web-devicons/blob/master/lua/nvim-web-devicons/icons-default.lua

					-- your personnal icons can go here (to override)
					-- you can specify color or cterm_color instead of specifying both of them
					-- DevIcon will be appended to `name`
					override = {
						zsh = {
							icon = "",
							color = "#428850",
							cterm_color = "65",
							name = "Zsh",
						},
					},
					-- globally enable different highlight colors per icon (default to true)
					-- if set to false all icons will have the default icon's color
					color_icons = true,
					-- globally enable default icons (default to false)
					-- will get overriden by `get_icons` option
					default = true,
					-- globally enable "strict" selection of icons - icon will be looked up in
					-- different tables, first by filename, and if not found by extension; this
					-- prevents cases when file doesn't have any extension but still gets some icon
					-- because its name happened to match some extension (default to false)
					strict = true,
					-- same as `override` but specifically for overrides by filename
					-- takes effect when `strict` is true
					override_by_filename = {
						["dockerfile"] = {
							icon = "",
						},
						[".zsh_profile"] = {
							icon = "",
						},
						[".zshrc"] = {
							icon = "",
						},
					},
					-- same as `override` but specifically for overrides by extension
					-- takes effect when `strict` is true
					override_by_extension = {
						["log"] = {
							icon = "",
							color = "#81e043",
							name = "Log",
						},
						["txt"] = {
							icon = "",
							color = "#81e043",
							name = "Text",
						},
					},
				})
			end,
		},
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
