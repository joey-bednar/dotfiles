# Dotfiles

These are the configs I use to setup my development environment. Some of the tools I use are:
- [Neovim](https://github.com/neovim/neovim)
- [Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh/)
- [Tmux](https://github.com/tmux/tmux)
- [Kitty](https://github.com/kovidgoyal/kitty)
- [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts)
- Custom bash scripts

## Installation

<details>
  <summary>Docker Container</summary>

##### Run in a Docker Container:
```
git clone https://github.com/joey-bednar/ansible \
cd ansible \
./test
```
Root password is `joey`.
</details>

<details>
  <summary>Automatic</summary>

##### Install using ansible:
```
git clone https://github.com/joey-bednar/ansible \
cd ansible \
./install
```
</details>

<details>
  <summary>Manual</summary>

##### Install dependencies:
```
sudo apt install curl unzip npm stow ripgrep fzf fontconfig -y
```

##### Install Neovim:
```
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage \
chmod u+x nvim.appimage \
./nvim.appimage --appimage-extract \
sudo mv squashfs-root / \
sudo ln -s /squashfs-root/AppRun /usr/bin/nvim
```

##### Install kitty as default terminal:
```
sudo apt install kitty -y \
sudo update-alternatives --config x-terminal-emulator
```

##### Install ohmyzsh:
```
sudo apt install zsh -y \
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" \
chsh -s `which zsh` \
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions \
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting \
```

##### Install tmux:
```
sudo apt install tmux -y \
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm \
```
Press `prefix`+`I` to install tmux plugins.

The `.zip` file with proportional and windows compatible fonts can be downloaded using:
```
curl -LO https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/DejaVuSansMono.zip
```

##### Install configs:
```
cd ~ \
git clone https://github.com/joey-bednar/dotfiles \
cd ~/dotfiles \
bash setup \
stow .
```

##### Reload Fonts:
```
fc-cache -f -v
```

##### Install Packer:
```
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```   

Open Neovim `nvim` and type `:PackerSync` to install plugins. Type `q` to close the install window and `:q!` to exit to the terminal.
</details>

