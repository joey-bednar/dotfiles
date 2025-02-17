# Dotfiles

These are the configs I use to setup my development environment.
- Editor: [Neovim](https://github.com/neovim/neovim)
- Shell: [Zsh](https://www.zsh.org) with [Zinit](https://github.com/zdharma-continuum/zinit)
- Terminal: [Kitty](https://github.com/kovidgoyal/kitty)
- Terminal Multiplexer: [Tmux](https://github.com/tmux/tmux)
- Window Manager: [i3wm](https://github.com/i3/i3)
- Font: [Custom patched](https://github.com/ryanoasis/nerd-fonts#font-patcher) with [DejaVu Sans Mono](https://dejavu-fonts.github.io/) base font. 
- Custom bash scripts

## Local Install

> [!NOTE]
> Requires `Ubuntu 24.04.04 (Noble)` or `Ubuntu 22.04.04 (Jammy)`.

Install one of the preset profiles:
```
make [personal|work|dev]
```

and logout. During login choose the i3 interface.

## Docker

Try out the environment inside a Docker container by pulling the latest image:
```
docker pull ghcr.io/joey-bednar/dev-env:latest
docker run --rm -it ghcr.io/joey-bednar/dev-env:latest
```
or by building the Docker image yourself:
```
make container
docker run --rm -it dev-env
```
