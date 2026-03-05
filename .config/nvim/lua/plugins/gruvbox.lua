return {
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		config = function()
			require("gruvbox").setup({
				terminal_colors = true,
				undercurl = true,
				underline = true,
				bold = true,
				italic = {
					strings = true,
					comments = true,
					operators = false,
					folds = true,
				},
				strikethrough = true,
				invert_selection = false,
				invert_signs = false,
				invert_tabline = false,
				invert_intend_guides = false,
				inverse = false,
				contrast = "soft",
				dim_inactive = false,
				transparent_mode = true,

				palette_overrides = {
					dark0_hard = "#282828",
					dark0 = "#282828",
					dark0_soft = "#282828",

					dark1 = "#3c3836",
					dark2 = "#504945",
					dark3 = "#665c54",
					dark4 = "#7c6f64",

					light0_hard = "#f9f5d7",
					light0 = "#fbf1c7",
					light0_soft = "#f2e5bc",

					light1 = "#ebdbb2",
					light2 = "#d5c4a1",
					light3 = "#bdae92",
					light4 = "#a89984",

					bright_red = "#ea6962",
					bright_green = "#a9b665",
					bright_yellow = "#d8a657",
					bright_blue = "#7daea3",
					bright_purple = "#d3869b",
					bright_aqua = "#89b482",
					bright_orange = "#e78a4e",

					neutral_red = "#ea6962",
					neutral_green = "#a9b665",
					neutral_yellow = "#d8a657",
					neutral_blue = "#7daea3",
					neutral_purple = "#d3869b",
					neutral_aqua = "#89b482",
					neutral_orange = "#e78a4e",

					faded_red = "#c14a4a",
					faded_green = "#6c782e",
					faded_yellow = "#b47109",
					faded_blue = "#45707a",
					faded_purple = "#945e80",
					faded_aqua = "#4c7a5d",
					faded_orange = "#c35e0a",

					gray = "#928374",
				},
			})

			vim.cmd("colorscheme gruvbox")
		end,
	},
}
