return {
	-- LSP Configuration & Plugins
	"neovim/nvim-lspconfig",
	lazy = true,
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		-- Automatically install LSPs to stdpath for neovim
		{ "williamboman/mason.nvim", config = true },
		"williamboman/mason-lspconfig.nvim",
		"folke/neodev.nvim",

		"hrsh7th/cmp-nvim-lsp", -- needed for lsp-capabilities, will remove
	},

	config = function()
		vim.lsp.config("*", {})

		-- Hide missing vim global
		vim.lsp.config("lua_ls", {

			settings = {
				Lua = {
					completion = {
						callSnippet = "Replace",
					},
					diagnostics = {
						globals = { "vim" },
						disable = { "missing-parameters", "missing-fields" },
					},
					workspace = {
						-- Make the server aware of Neovim runtime files
						library = vim.api.nvim_get_runtime_file("", true),
					},
				},
			},
		})

		-- Disable Python type checking errors
		vim.lsp.config("pyright", {
			settings = {
				python = {
					analysis = {
						typeCheckingMode = "off",
					},
				},
			},
		})

		-- Fix keyordering error in YAML
		vim.lsp.config("yamlls", {
			settings = {
				yaml = {
					keyOrdering = false,
				},
			},
		})

		-- Start Ansible LSP only in ansible dir
		vim.lsp.config("ansiblels", {
			filetypes = { "ansible.yaml" },
		})

		-- Fix goto definition in C
		vim.lsp.config("clangd", {
			cmd = {
				"clangd",
				"--offset-encoding=utf-16",
			},
		})

		vim.diagnostic.config({
			virtual_text = true,
		})

		-- Mason
		require("mason").setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		require("mason-lspconfig").setup({
			ensure_installed = {
				"bashls",
				"dockerls",
				"lua_ls",
				"pyright",
				"yamlls",
			},
		})

		-- Is Helm file if Chart.yaml in current or parent dirs
		local function is_helm_file(path)
			local check = vim.fs.find("Chart.yaml", { path = vim.fs.dirname(path), upward = true })
			return not vim.tbl_isempty(check)
		end

		-- Is Ansible file if path contains ansible
		local function is_ansible_file(path)
			return string.find(vim.fs.dirname(path), "ansible")
		end

		-- Is Docker compose file if filename contains "compose"
		local function is_compose_file(path)
			local check = string.find(vim.fn.expand("%"), ".*compose%.ya?ml$")
			return check
		end

		-- Is YAML otherwise
		local function yaml_filetype(path, bufname)
			if is_compose_file(path) then
				return "yaml"
			elseif is_helm_file(path) then
				return "helm.yaml"
			elseif is_ansible_file(path) then
				return "ansible.yaml"
			end
			return "yaml"
		end

		vim.filetype.add({
			extension = {
				yaml = yaml_filetype,
				yml = yaml_filetype,
			},
			filename = {
				["Chart.yaml"] = "yaml",
				["Chart.lock"] = "yaml",
			},
		})

		-- Use LspAttach autocommand to only map the following keys
		-- after the language server attaches to the current buffer
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				-- Buffer local mappings.
				-- See `:help vim.lsp.*` for documentation on any of the below functions
				local opts = { buffer = ev.buf }

				-- Format file with :Format or <leader>lf
				vim.api.nvim_create_user_command(
					"Format",
					":lua vim.lsp.buf.format({ timeout_ms = 5000 })",
					{ desc = "LSP format buffer." }
				)
				vim.keymap.set("n", "<leader>lf", "<cmd>Format<CR>", { desc = "LSP format buffer." })

				-- goto definition
				vim.keymap.set("n", "gd", function()
					vim.lsp.buf.definition()
				end, { buffer = ev.buf, desc = "LSP goto definition." })

				-- goto type definition
				vim.keymap.set("n", "gT", function()
					vim.lsp.buf.type_definition()
				end, { buffer = ev.buf, desc = "LSP goto type definition." })

				-- hover
				vim.keymap.set("n", "K", function()
					vim.lsp.buf.hover()
				end, { buffer = ev.buf, desc = "LSP hover show information." })

				-- next/prev diagnostic
				vim.keymap.set("n", "[d", function()
					vim.diagnostic.goto_next()
				end, { buffer = ev.buf, desc = "LSP goto next diagnostic." })
				vim.keymap.set("n", "]d", function()
					vim.diagnostic.goto_prev()
				end, { buffer = ev.buf, desc = "LSP goto previous diagnostic." })

				-- rename
				vim.keymap.set("n", "<leader>rn", function()
					vim.lsp.buf.rename()
				end, { buffer = ev.buf, desc = "LSP rename value under cursor." })

				-- show error
				vim.keymap.set("n", "<leader>e", function()
					vim.diagnostic.open_float(0, { scope = "line" })
				end, { buffer = ev.buf, desc = "LSP show diagnostic error." })
			end,
		})
	end,
}
