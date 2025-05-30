# Dotfiles

These are the configs I use to setup my development environment.

- Editor: [Neovim](https://github.com/neovim/neovim)
- Shell: [Zsh](https://www.zsh.org) with [Zinit](https://github.com/zdharma-continuum/zinit)
- Terminal: [Kitty](https://github.com/kovidgoyal/kitty)
- Terminal Multiplexer: [Tmux](https://github.com/tmux/tmux)
- Window Manager: [i3](https://github.com/i3/i3)
- Application Launcher: [Rofi](https://github.com/davatorium/rofi)
- Status bar: [Polybar](https://github.com/polybar/polybar)
- Notifications: [Dunst](https://github.com/dunst-project/dunst)
- Font: [Custom patched](https://github.com/ryanoasis/nerd-fonts#font-patcher) with [DejaVu Sans Mono](https://dejavu-fonts.github.io/) base font. 
- Custom bash scripts

## Local Install

> [!NOTE]
> Requires `Ubuntu 24.04.04 (Noble)` or `Ubuntu 22.04.04 (Jammy)`.

1. Clone into your home directory:
```
git clone https://github.com/joey-bednar/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

2. Install one of the preset profiles:
```
make [personal|work|dev]
```

3. Logout or restart. During login select the `i3` interface.

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
