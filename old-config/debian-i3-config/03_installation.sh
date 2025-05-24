#!/bin/bash

echo "Copying configurations..."
mkdir -p ~/.local/share/fonts
cp fonts/* ~/.local/share/fonts
mkdir -p ~/.emacs.d
cp .emacs.d/* ~/.emacs.d
cp -r .config/* ~/.config
cp .bashrc ~/.bashrc
cp .alacritty.yml ~/.alacritty.yml
echo "Finished task"
