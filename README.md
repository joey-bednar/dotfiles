## Installation Instructions

Install dependencies:
```
sudo apt install curl git nodejs npm stow -y \
sudo npm cache clean -f \
sudo npm install -g n \
sudo n stable
```
Install Neovim:
```
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage \
chmod u+x nvim.appimage \
./nvim.appimage --appimage-extract \
sudo mv squashfs-root / \
sudo ln -s /squashfs-root/AppRun /usr/bin/nvim
```

Install Tree Sitter and ripgrep:
```
sudo npm install -g tree-sitter-cli \
sudo apt install ripgrep -y
```

Install DejuVuSansMono Nerd Font:
```
mkdir ~/.fonts \
cd ~/.fonts \
curl -LO https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/DejaVuSansMono.zip \
unzip DejaVuSansMono.zip
```

Download repo:
```
cd ~ \
git clone https://github.com/joey-bednar/dotfiles
```

Create symlinks:
```
cd ~/dotfiles \
stow .
```

Install Packer:
```
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```   

Open Neovim `nvim` and type `:PackerSync` to install plugins. Type `q` to close the install window and `:q!` to exit to the terminal.
