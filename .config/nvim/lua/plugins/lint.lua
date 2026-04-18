return {
	"mfussenegger/nvim-lint",
	lazy = true,
	event = { "BufReadPost", "BufWritePost" },
	config = function()
		local lint = require("lint")

		local function get_venv_path()
			local venv = os.getenv("VIRTUAL_ENV")
			if venv then
				return venv .. "/bin/"
			end
			return ""
		end

		lint.linters.mypy = vim.tbl_deep_extend("force", lint.linters.mypy, {
			cmd = get_venv_path() .. "mypy",
			args = vim.list_extend(
				{ "--python-executable", get_venv_path() .. "python3" },
				vim.deepcopy(lint.linters.mypy.args or {})
			),
		})

		lint.linters_by_ft = {
			python = { "mypy" },
			bash = { "shellcheck" },
		}

		vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
			callback = function()
				lint.try_lint()
			end,
		})
	end,
}
