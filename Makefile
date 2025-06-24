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
	find ${HOME} -maxdepth 1 -xtype l -delete
	find ${HOME}/.config/ -xtype l -delete
	mkdir -p ${HOME}/.fonts
	find ${HOME}/.fonts/ -xtype l -delete
	find ${HOME}/.local/ -xtype l -delete
	stow . --restow

.PHONY: setup
setup:
	bash .local/bin/setup
