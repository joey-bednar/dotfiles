return {
	-- LSP Configuration & Plugins
	"neovim/nvim-lspconfig",
	lazy = true,
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		-- Automatically install LSPs to stdpath for neovim
		{ "williamboman/mason.nvim", config = true },
		"williamboman/mason-lspconfig.nvim",

		"hrsh7th/cmp-nvim-lsp", -- needed for lsp-capabilities, will remove
	},

	config = function()
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

		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"pyright",
				"dockerls",
				"lua_ls",
				"bashls",
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

		-- Fix Undefined global 'vim'
		lspconfig.lua_ls.setup({
			settings = {
				Lua = {
					runtime = {
						version = "LuaJIT",
					},
					workspace = {
						checkThirdParty = false,
						library = {
							"${3rd}/luv/library",
							unpack(vim.api.nvim_get_runtime_file("", true)),
						},
					},
					telemetry = { enable = false },
					diagnostics = {
						globals = { "vim" },
					},
					completion = {
						callSnippet = "Replace",
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
	end,
}
