MAKEFLAGS += --silent

.PHONY: all
all:
	make -s stow
	make -s setup

.PHONY: personal
personal:
	./install/personal

.PHONY: work
work:
	./install/work

.PHONY: dev
dev:
	./install/dev

.PHONY: container
container:
	./install/container

.PHONY: format
format:
	stylua .config/nvim/

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
