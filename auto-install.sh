#!/usr/bin/env bash

DEPS="curl git yay stow zsh i3 rofi"
YAY="polybar"

sudo pacman -S --noconfirm $DEPS

yay -S $YAY


# Install oh-my-zss
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

rm -f ~/.zshrc # Remove local installation of zsh, stow will overwrite it


# Auto-clone
git clone https://github.com/ignaciobll/.dotfiles.git

cd .dotfiles


# Copy configs
CONFIG=$(ls -d */)

for conf in $CONFIG; do
    stow $conf
done
