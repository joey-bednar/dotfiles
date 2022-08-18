## Installation Instructions

Install Neovim, nodejs, npm, pip3, git, exuberant-ctags, and curl: `sudo apt install neovim nodejs npm python3-pip git exuberant-ctags curl -y`

Install yarn: `sudo npm install -g yarn`

Update Nodejs to stable release: 
```
sudo npm cache clean -f

sudo npm install -g n

sudo n stable
```

Download and move init.vim to config file:
```
git clone https://github.com/joey-bednar/neovim-config

mkdir ~/.config/nvim/

mv ~/neovim-config/init.vim ~/.config/nvim/

rm -rf ~/neovim-config/
```

Install Vim Plug:
```
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```   

Install onehalf theme: `git clone https://github.com/sonph/onehalf`

Load profile: `source ./onehalf/gnome-terminal/onehalfdark.sh`

Open Neovim `nvim` and type `:PlugInstall` to install plugins from init.vim.

Go to the Coc directory: `cd ~/.local/share/nvim/plugged/coc.nvim`

Install and build Coc:
```
yarn install

yarn build
```
Open Neovim `nvim` and type `:CocInstall coc-pyright` to install Python3 autocompletion.

Type `:CocInstall coc-clangd` to install C autocompletion.


If clangd is not in your $PATH, type `:CocCommand clangd.install` to finish the C autocompletion install.
