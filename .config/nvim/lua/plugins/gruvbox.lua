return {
	"sainnhe/gruvbox-material",
	priority = 1000,
	lazy = false,
	transparent_mode = true,
	config = function()
		vim.g.gruvbox_material_background = "hard" -- hard, soft, medium
		vim.g.gruvbox_material_foreground = "material" -- original, mix, material
		vim.g.gruvbox_material_enable_italic = 1
		vim.g.gruvbox_material_sign_column_background = "none"
		vim.g.gruvbox_material_transparent_background = 1

		local grpid = vim.api.nvim_create_augroup("custom_highlights_gruvboxmaterial", {})
		vim.api.nvim_create_autocmd("ColorScheme", {
			group = grpid,
			pattern = "gruvbox-material",
			command = "hi NvimTreeNormal                  guibg=NONE ctermbg=NONE |"
				.. "hi NvimTreeEndOfBuffer                guibg=NONE |"
				.. "hi NoiceCmdlinePopupBorderCmdline     guifg=#ebdbb2 guibg=#282828 |"
				.. "hi TelescopePromptBorder              guifg=#ebdbb2 guibg=#282828 |"
				.. "hi TelescopePromptNormal              guifg=#ebdbb2 guibg=#282828 |"
				.. "hi TelescopePromptTitle               guifg=#ebdbb2 guibg=#282828 |"
				.. "hi TelescopePromptPrefix              guifg=#ebdbb2 guibg=#282828 |"
				.. "hi TelescopePromptCounter             guifg=#ebdbb2 guibg=#282828 |"
				.. "hi TelescopePreviewTitle              guifg=#ebdbb2 guibg=#282828 |"
				.. "hi TelescopePreviewBorder             guifg=#ebdbb2 guibg=#282828 |"
				.. "hi TelescopeResultsTitle              guifg=#ebdbb2 guibg=#282828 |"
				.. "hi TelescopeResultsBorder             guifg=#ebdbb2 guibg=#282828 |"
				.. "hi TelescopeMatching                  guifg=#d79921 guibg=#282828 |"
				.. "hi TelescopeSelection                 guifg=#ffffff guibg=#32302f |"
				.. "hi FloatBorder                        guifg=#ebdbb2 guibg=#282828 |"
				.. "hi BqfPreviewBorder                   guifg=#ebdbb2 guibg=#282828 |"
				.. "hi NormalFloat                        guibg=#282828 |"
				.. "hi IndentBlanklineContextChar         guifg=#d3869b |"
				.. "hi StatusColumnBorder                 guifg=#282828 |"
				.. "hi StatusColumnBuffer                 guibg=#282828 |"
				.. "hi CursorLineNr                       guifg=#d79921 |"
				.. "hi CodewindowBorder                   guifg=#ebdbb2 |"
				.. "hi TabLine                            guibg=#282828 |"
				.. "hi TreesitterContext				  guibg=#1d2021",
		})
		vim.cmd("colorscheme gruvbox-material")
	end,
}
-- TODO: adjust telescope colors
