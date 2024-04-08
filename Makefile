.PHONY: format
.SILENT: format
format:
	stylua .config/nvim/

.PHONY: update
.SILENT: update
update:
	git fetch origin
	git reset --hard origin/main
	stow . --adopt
	git reset --hard origin/main
	stow . --restow

.PHONY: setup
.SILENT: setup
setup:
	bash .local/bin/setup

# TODO: add default: pull, conda init, remove symlinks, stow
