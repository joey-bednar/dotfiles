## Installation Instructions

Install Neovim and dependencies: 
```
sudo apt install neovim nodejs npm python3-pip git exuberant-ctags curl -y
```

Install yarn: 
```
sudo npm install -g yarn
```

Update Nodejs to stable release: 
```
sudo npm cache clean -f \
sudo npm install -g n \
sudo n stable
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

Install onehalf theme
```
git clone https://github.com/sonph/onehalf \
source ./onehalf/gnome-terminal/onehalfdark.sh
```

Open Neovim `nvim` and type `:PlugInstall` to install plugins from init.vim.

Install and build Coc:
```
cd ~/.local/share/nvim/plugged/coc.nvim \
yarn install \
yarn build
```

Open Neovim `nvim` and type `:CocInstall coc-pyright` to install Python3 autocompletion. Type `:q!` to exit to the terminal.

Move the Coc config into the correct folder
```
mv ~/neovim-config/coc-settings.json ~/.config/nvim/
```

Open Neovim `nvim` and type `:CocInstall coc-clangd` to install C autocompletion. Type `:CocCommand clangd.install` to move clangd to your path. Type `:q!` to exit to the terminal.

Delete the cloned folder
```
rm -rf ~/neovim-config/
```
