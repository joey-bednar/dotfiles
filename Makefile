MAKEFLAGS += --silent

.PHONY: all
all:
	make -s update
	make -s setup

.PHONY: format
format:
	stylua .config/nvim/
	shfmt --indent 4 --space-redirects --write . .zshrc .zsh_profile

.PHONY: update
update:
	git fetch origin
	git reset --hard origin/main
	stow . --adopt
	git reset --hard origin/main
	stow . --restow

.PHONY: setup
setup:
	bash .local/bin/setup
