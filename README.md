## Install

Install Neovim, curl, Plug, and onehalf
```
sudo apt install neovim curl -y

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    
git clone https://github.com/sonph/onehalf

source ./onehalf/gnome-terminal/onehalfdark.sh
```

Type `:PlugInstall` in Neovim to install plugins
