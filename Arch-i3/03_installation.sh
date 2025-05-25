#!/bin/bash

cp -r gtk-3.0/ ~/.config/
cp -r i3/ ~/.config/
cp -r i3status/ ~/.config/
cp -r wallpapers/ ~/.config/
cp -r fonts/ ~/.local/share/
if [ -d "~/.emacs.d"]; then
    cp emacs.d/* ~/.emacs.d
else
    mkdir ~/.emacs.d
    cp emacs.d/* ~/.emacs.d
fi
cp bashrc ~/.bashrc
cp alacritty.toml ~/.alacritty.toml
cp clang-format ~/.clang-format
pip install fortls --break-system-packages
pip install fpm --break-system-packages
pip install ford --break-system-packages
