return {
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

	config = function()
		local telescope = require("telescope")
		local config = require("telescope.config")
		local actions = require("telescope.actions")
		local builtin = require("telescope.builtin")

		-- Telescope Mappings

		-- Resume Telescope
		vim.keymap.set("n", "<leader>fr", builtin.resume, {})

		-- Find files
		vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
		vim.keymap.set("n", "<leader>fg", builtin.git_files, {})

		-- Find strings
		vim.keymap.set("n", "<leader>fs", builtin.live_grep, {})

		-- Find git
		vim.keymap.set("n", "<leader>fc", builtin.git_commits, {})

		-- Find all references to var under cursor
		vim.keymap.set("n", "<leader>gr", builtin.lsp_references, {})

		-- Show all keymaps
		vim.keymap.set("n", "<leader>fk", builtin.keymaps, {})

		-- Clone the default Telescope configuration
		local vimgrep_arguments = { unpack(config.values.vimgrep_arguments) }

		telescope.setup({
			defaults = {
				vimgrep_arguments = vimgrep_arguments,
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous,
						["<C-j>"] = actions.move_selection_next,
					},
				},
			},
			pickers = {
				find_files = {
					find_command = { "rg", "--files", "--hidden", "--glob", "!{**/.git/*,**/node_modules/*}" },
				},
				live_grep = {
					additional_args = { "--hidden", "--glob", "!{**/.git/*,**/node_modules/*}" },
				},
			},
			extensions = {
				fzf = {
					fuzzy = true, -- false will only do exact matching
					override_generic_sorter = true, -- override the generic sorter
					override_file_sorter = true, -- override the file sorter
					case_mode = "smart_case", -- or "ignore_case" or "respect_case"
					-- the default case_mode is "smart_case"
				},
			},
		})

		require("telescope").load_extension("fzf")
	end,
}
-- TODO: find starting at base of git dir
-- TODO: try telescope lsp_stuff
-- TODO: setup telescope file_browser to search, add files
