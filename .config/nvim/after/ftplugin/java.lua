-- jdtls needs a per-project workspace + root_dir, so it's started here
-- instead of through the generic mason-lspconfig/vim.lsp.enable path
local jdtls_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls"

if vim.fn.isdirectory(jdtls_path) == 0 then
	vim.notify("jdtls not installed. Run :MasonToolsInstall", vim.log.levels.WARN)
	return
end

local ok, jdtls = pcall(require, "jdtls")
if not ok then
	return
end

local launcher_jar = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")

-- Deliberately excludes build.gradle(.kts)/pom.xml: in a multi-module project
-- those exist in every submodule too, so find_root (which checks all markers
-- at each directory level before walking up) would stop at the nearest
-- submodule instead of the repo root, giving jdtls a broken partial project.
local root_dir = require("jdtls.setup").find_root({ ".git", "gradlew", "mvnw" })
if not root_dir then
	return
end

local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspace/" .. project_name

-- Some projects' Gradle buildscripts need a newer JVM than jdtls's own minimum
-- (21) to even evaluate (e.g. WorldEdit's crankcase plugin requires JVM 25).
-- Gradle's daemon defaults to whatever JVM launched the parent process, so
-- launching jdtls itself under the newest available JDK covers this — that's
-- more reliable than the java.import.gradle.java.home setting, which arrives
-- via workspace/didChangeConfiguration *after* jdtls already kicks off the
-- first Gradle import in response to "initialized", too late to apply.
local newest_jdk = vim.fn.glob("/usr/lib/jvm/java-25*", true, true)[1]
local java_cmd = newest_jdk and (newest_jdk .. "/bin/java") or "java"

jdtls.start_or_attach({
	cmd = {
		java_cmd,
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-Xmx1g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",
		"-jar",
		launcher_jar,
		"-configuration",
		jdtls_path .. "/config_linux",
		"-data",
		workspace_dir,
	},

	root_dir = root_dir,

	capabilities = require("blink.cmp").get_lsp_capabilities(),

	settings = {
		java = {
			signatureHelp = { enabled = true },
			completion = {
				favoriteStaticMembers = {
					"org.junit.Assert.*",
					"org.junit.jupiter.api.Assertions.*",
				},
			},
		},
	},

	init_options = {
		bundles = {},
	},
})
