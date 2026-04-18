return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},

	config = function()
		local telescope = require("telescope")
		local config = require("telescope.config")
		local actions = require("telescope.actions")
		local builtin = require("telescope.builtin")

		-- Telescope Mappings

		-- Resume Telescope
		vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "Telescope resume." })

		-- Spelling suggestions
		vim.keymap.set("n", "z=", builtin.spell_suggest, { desc = "Search spelling suggestions." })

		-- Find files/strings in whole directory
		vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files." })
		vim.keymap.set("n", "<leader>fs", builtin.live_grep, { desc = "Telescope find string live grep." })
		vim.keymap.set("n", "<leader>fg", builtin.git_files, { desc = "Telescope find git versioned files." })

		-- Find files/strings in buffer directory
		vim.keymap.set("n", "<leader>fF", function()
			builtin.find_files({ cwd = vim.fn.expand("%:p:h") })
		end, { desc = "Telescope find files in buffer's directory." })
		vim.keymap.set("n", "<leader>fS", function()
			builtin.live_grep({ cwd = vim.fn.expand("%:p:h") })
		end, { desc = "Telescope live grep in buffer's directory." })

		-- -- Find strings without live results
		-- vim.keymap.set("n", "<leader>fS", function()
		-- 	builtin.grep_string({ search = vim.fn.input("Grep > ") })
		-- end, { desc = "Telescope find string without live grep." })

		-- File strings in buffer
		vim.keymap.set(
			"n",
			"<leader>/",
			":Telescope current_buffer_fuzzy_find sorting_strategy=ascending prompt_position=top<CR>",
			{ desc = "Telescope find string in current buffer." }
		)

		-- Find git commits/branches
		vim.keymap.set("n", "<leader>fc", function()
			builtin.git_commits({
				git_command = {
					"git",
					"log",
					"--pretty=%h %<(20)%ar %<(20)%s",
					"--abbrev-commit",
					"--decorate",
					"--",
					".",
				},
			})
		end, { desc = "Telescope find commits." })

		vim.keymap.set("n", "<leader>fC", function()
			builtin.git_bcommits({

				git_command = {
					"git",
					"log",
					"--pretty=%h %<(20)%ar %<(20)%s",
					"--abbrev-commit",
				},
			})
		end, { desc = "Telescope find commits from current buffer." })
		vim.keymap.set("n", "<leader>fb", builtin.git_branches, { desc = "Telescope find git branches." })

		-- Find all references to var under cursor
		vim.keymap.set("n", "gr", builtin.lsp_references, { desc = "LSP find all references under cursor." })

		telescope.setup({
			defaults = {
				vimgrep_arguments = {
					"rg",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
					"--hidden",
					"--glob",
					"!{**/.git/*,**/node_modules/*}",
				},
				preview = {
					filesize_limit = 0.1, -- MB
				},
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous,
						["<C-j>"] = actions.move_selection_next,
						["<C-u>"] = actions.preview_scrolling_up,
						["<C-d>"] = actions.preview_scrolling_down,
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
