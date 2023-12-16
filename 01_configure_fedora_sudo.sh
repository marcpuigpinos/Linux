#!/bin/bash

dnf update -y && dnf upgrade -y
dnf groupinstall "Herramientas de desarrollo" -y && dnf groupinstall "Herramientas y Librerías de Desarrollo en C" -y
dnf install vim -y
dnf install python-pip -y
dnf install gfortran
dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm -y
dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y
dnf update -y
dnf install akmod-nvidia -y 
dnf install xorg-x11-drv-nvidia-cuda -y 
dnf install rofi -y
curl -s https://ohmyposh.dev/install.sh | bash -s -- -d ~/.local/bin
mkdir fonts
cd fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/Hack.zip
cd ..
mkdir ~/.local/share/fonts
cp fonts/* ~/.local/share/fonts
rm -rf fonts
rpm --import https://packages.microsoft.com/keys/microsoft.asc
sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
dnf check-update -y
dnf install code -y
dnf install neovim -y
dnf install nodejs -y
