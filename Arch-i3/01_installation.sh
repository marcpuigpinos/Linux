#!/bin/bash

sudo pacman -Sy --noconfirm
sudo pacman -Syu --noconfirm 
sudo pacman -Rns $(pacman -Qdtq) --noconfirm
sudo pacman -Sy xorg-xrandr --noconfirm
sudo pacman -Sy arandr --noconfirm
sudo pacman -Sy brightnessctl --noconfirm
sudo pacman -Sy base-devel --noconfirm
sudo pacman -Sy pavucontrol --noconfirm
sudo pacman -Sy gvfs --noconfirm
sudo pacman -Sy thunar --noconfirm
sudo pacman -Sy xclip --noconfirm
sudo pacman -Sy git --noconfirm
sudo pacman -Sy bat --noconfirm
sudo pacman -Sy fzf --noconfirm
sudo pacman -Sy emacs --noconfirm 
sudo pacman -Sy gcc-fortran --noconfirm 
sudo pacman -Sy python-pip --noconfirm 
sudo pacman -Sy alacritty --noconfirm 
sudo pacman -Sy texlive-most --noconfirm 
sudo pacman -Sy htop --noconfirm 
sudo pacman -Sy blueman --noconfirm
sudo pacman -Sy bluez --noconfirm
sudo pacman -Sy bluez-utils --noconfirm
sudo pacman -Sy cmake --noconfirm
sudo pacman -Sy meson --noconfirm
sudo pacman -Sy feh --noconfirm
sudo pacman -Sy os-prober --noconfirm
sudo pacman -Sy grub --noconfirm
sudo pacman -Sy clang --noconfirm
sudo pacman -Sy man-db --nocnfirm
sudo pacman -Sy xdg-user-dirs --noconfirm

sudo systemctl enable bluetooth
sudo systemctl start bluetooth
