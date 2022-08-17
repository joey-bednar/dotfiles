## Setup Neovim Configuration

Install Neovim and curl `sudo apt install neovim curl -y`

Install Vim Plug
```
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```   

Install onehalf theme
```
git clone https://github.com/sonph/onehalf
source ./onehalf/gnome-terminal/onehalfdark.sh
```

Type `:PlugInstall` in Neovim to install plugins from init.vim
