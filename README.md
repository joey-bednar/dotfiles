## Setup Neovim Configuration

Download and move init.vim to config file
```
git clone https://github.com/joey-bednar/neovim-config

mkdir ~/.config/nvim/

mv ~/neovim-config/init.vim ~/.config/nvim/

rm -rf ~/neovim-config/
```

Install Neovim and curl `sudo apt install neovim curl -y`

Install Vim Plug
```
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```   

Install onehalf theme `git clone https://github.com/sonph/onehalf`

Load profile `source ./onehalf/gnome-terminal/onehalfdark.sh`

Open Neovim `nvim` and type `:PlugInstall` to install plugins from init.vim
