MAKEFLAGS += --silent

.PHONY: all
all:
	./install/personal

.PHONY: personal
personal:
	./install/personal

.PHONY: work
work:
	./install/work

.PHONY: job
job:
	./install/job

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
	mkdir -p ${HOME}/.config
	find ${HOME}/.config/ -xtype l -delete
	mkdir -p ${HOME}/.fonts
	find ${HOME}/.fonts/ -xtype l -delete
	find ${HOME}/.local/ -xtype l -delete
	stow . --restow
