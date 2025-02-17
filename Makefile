MAKEFLAGS += --silent

.PHONY: all
all:
	ansible/install personal

.PHONY: personal
personal:
	ansible/install personal

.PHONY: work
work:
	ansible/install work

.PHONY: dev
dev:
	ansible/install dev

.PHONY: container
container:
	ansible/install container

.PHONY: format
format:
	stylua .config/nvim/

.PHONY: update
update:
	git fetch origin
	git reset --hard origin/main
	make -s stow

.PHONY: stow
stow:
	stow . --restow
	find ${HOME} -maxdepth 1 -xtype l -delete
	find ${HOME}/.config/ -xtype l -delete
	find ${HOME}/.fonts/ -xtype l -delete
	find ${HOME}/.local/ -xtype l -delete

.PHONY: setup
setup:
	bash .local/bin/setup
