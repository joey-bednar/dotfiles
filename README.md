## Installation Instructions

Install dependencies:
```
sudo apt install curl git nodejs npm -y \
sudo npm cache clean -f \
sudo npm install -g n \
sudo n stable
```
Install Neovim
```
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage \
chmod u+x nvim.appimage \
./nvim.appimage --appimage-extract \
sudo mv squashfs-root / \
sudo ln -s /squashfs-root/AppRun /usr/bin/nvim
```

Install language servers:
```
sudo npm install -g pyright \
&& sudo apt install clangd \
&& sudo npm install -g dockerfile-language-server-nodejs
```

Download and move init.vim to config file:
```
git clone https://github.com/joey-bednar/neovim-config \
mkdir ~/.config/nvim/ \
mv ~/neovim-config/init.vim ~/.config/nvim/
```

Install Vim Plug:
```
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```   

Install onehalf theme:
```
git clone https://github.com/sonph/onehalf \
source ./onehalf/gnome-terminal/onehalfdark.sh
```

Open Neovim `nvim` and type `:PlugInstall` to install plugins from init.vim. Type `q` to close the install window and `:q!` to exit to the terminal.

Delete the cloned folder:
```
rm -rf ~/neovim-config/
```
