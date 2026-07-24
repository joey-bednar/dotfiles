# Dotfiles

Personal dev environment configs managed with GNU Stow.
Supports Arch Linux and Ubuntu 24.04.

## Stack

- **Editor:** Neovim (`.config/nvim/`)
- **Shell:** Zsh + Zinit (`.zshrc`)
- **Terminal:** Kitty (`.config/kitty/`)
- **Multiplexer:** Tmux (`.tmux.conf`)
- **Window Manager:** i3 (`.config/i3/`)
- **Status Bar:** Polybar (`.config/polybar/`)
- **Launcher:** Rofi (`.config/rofi/`)
- **Notifications:** Dunst (`.config/dunst/`)
- **Scripts:** `.local/bin/`

## Installation

```bash
make [personal|work|dev]   # installs packages + stows configs
```

GNU Stow symlinks everything from `~/dotfiles` into `~`. After editing
any config file here, changes are live immediately (symlinks, no copy needed).

## Rules

- NEVER modify files outside this repo
- Match the existing style and formatting in whatever file you're editing
- Keep changes minimal — only touch what's needed for the task
- If a change requires a reload or restart to take effect, say so explicitly
- For shell scripts in `.local/bin/`, ensure they are POSIX-compatible unless
  they explicitly use bash/zsh features (check the shebang line)
- Prefer editing existing config over adding new files unless a new file is
  clearly the right approach

## Validation Commands

After making changes, suggest the appropriate command to validate:

| Tool     | Validate                        | Reload                              |
|----------|---------------------------------|-------------------------------------|
| i3       | `i3 -C`                         | `i3-msg reload`                     |
| tmux     | n/a                             | `tmux source ~/.tmux.conf`          |
| zsh      | `zsh -n ~/.zshrc`               | `source ~/.zshrc` or new shell      |
| neovim   | `:checkhealth` inside nvim      | restart nvim                        |
| polybar  | n/a                             | restart polybar                     |
| kitty    | `kitty --debug-config`          | `ctrl+shift+f5` or restart          |

Always remind me to run the relevant validate/reload after a change.
