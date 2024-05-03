local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("set")
require("lazy").setup("plugins", {
	change_detection = {
		notify = false,
	},
})
require("keymaps")

-- TODO: setup debugger
-- TODO: test gitlab support
-- TODO: try out twilight.nvim
-- TODO: setup a project-wide find/replace
