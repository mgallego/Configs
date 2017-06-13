#!/bin/sh

#Install minimun applications
sudo apt-get install git emacs tmux zsh exuberant-ctags

#ohmyzsh
rm -rf ~/.oh-my-zsh
wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O - | sh

#Link configurations
rm -rf ~/.zshrc ~/.tmux.conf ~/.emacs ~/.emacs.modes
ln -s `pwd`/.zshrc ~/
ln -s `pwd`/.tmux.conf ~/

#emacs config and modes
cd ../emacs
rm -rf ./.emacs.modes
./install_modes.sh
ln -s `pwd`/.emacs ~/
ln -s `pwd`/.emacs.modes ~/
