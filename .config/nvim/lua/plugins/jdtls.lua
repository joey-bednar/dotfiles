-- nvim-java wraps jdtls (+ lombok, java-test, java-debug-adapter, spring-boot
-- tools) with sane defaults and its own tool/JDK installer, so it replaces
-- both mfussenegger/nvim-jdtls and our manual after/ftplugin/java.lua setup.
return {
	"nvim-java/nvim-java",
	ft = "java",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"mfussenegger/nvim-dap",
		{
			"JavaHello/spring-boot.nvim",
			commit = "218c0c26c14d99feca778e4d13f5ec3e8b1b60f0",
		},
	},
	config = function()
		require("java").setup()
		vim.lsp.enable("jdtls")
	end,
}
