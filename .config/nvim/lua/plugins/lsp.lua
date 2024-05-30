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
		--require('java').setup()

		-- Error Settings
		local signs = { Error = "✗", Warn = "✗", Hint = "✗", Info = "✗" }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
		end

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
				"clangd",
				"dockerls",
				"lua_ls",
				"pyright",
				"yamlls",
			},
		})

		local lspconfig = require("lspconfig")
		local lsp_capabilities =
			require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
		lsp_capabilities.textDocument.completion.completionItem.snippetSupport = true

		require("mason-lspconfig").setup_handlers({
			function(server_name)
				lspconfig[server_name].setup({
					capabilities = lsp_capabilities,
				})
			end,
		})

		-- Lua/nvim config LSP
		require("neodev").setup({
			override = function(_, library)
				library.enabled = true
				library.plugins = true
			end,
			pathStrict = true,
		})

		lspconfig.lua_ls.setup({
			settings = {
				Lua = {
					completion = {
						callSnippet = "Replace",
					},
					diagnostics = {
						disable = { "missing-parameters", "missing-fields" },
					},
				},
			},
		})

		-- Disable Python3 type checking
		lspconfig.pyright.setup({
			settings = {
				python = {
					analysis = {
						typeCheckingMode = "off",
					},
				},
			},
		})

		-- Fix keyordering error in YAML
		lspconfig.yamlls.setup({
			settings = {
				yaml = {
					keyOrdering = false,
				},
			},
		})

		-- Filetype handling for YAML/Helm/Ansible
		local function is_helm_file(path)
			local check = vim.fs.find("Chart.yaml", { path = vim.fs.dirname(path), upward = true })
			return not vim.tbl_isempty(check)
		end

		local function is_ansible_file(path)
			local check = vim.fs.find("ansible", { path = vim.fs.dirname(path), upward = true })
			return not vim.tbl_isempty(check)
		end

		local function yaml_filetype(path, bufname)
			if is_helm_file(path) then
				return "helm.yaml"
			elseif is_ansible_file(path) then
				return "ansible.yaml"
			end
			return "yaml"
		end

		local function tmpl_filetype(path, bufname)
			return is_helm_file(path) and "helm.tmpl" or "template"
		end

		local function tpl_filetype(path, bufname)
			return is_helm_file(path) and "helm.tmpl" or "smarty"
		end

		vim.filetype.add({
			extension = {
				yaml = yaml_filetype,
				yml = yaml_filetype,
				tmpl = tmpl_filetype,
				tpl = tpl_filetype,
			},
			filename = {
				["Chart.yaml"] = "yaml",
				["Chart.lock"] = "yaml",
			},
		})

		-- Start Ansible LSP only in ansible dir
		lspconfig.ansiblels.setup({
			filetypes = { "ansible.yaml" },
		})

		-- Java setup
		--lspconfig.jdtls.setup({
		--settings = {
		--java = {
		--configuration = {
		--runtimes = {
		--{
		--name = "JavaSE-21",
		--path = "/opt/jdk-21",
		--default = true,
		--},
		--},
		--},
		--},
		--},
		--})

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
