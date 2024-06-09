#!/bin/bash

newline() {
	echo " "
}

help() {
	echo "installation.sh usage:"
	echo "Command: ./installation.sh [ARGUMENTS]"
	echo "Arguments:"
	echo "  --help: prints some help."
	echo "  --catala: installation for systems in catalan language."
	echo "  --castellano: installation for systems in spanish language."
}

# Checking the correctness of CLI arguments.
if [ $# -ne 1 ]; then
	echo "Error: Incorrect number of arguments."
	newline
	help
	exit 1
fi

# help
if [ "$1" == "--help" ]; then
	help
	newline
	exit 0
fi

# If language introduced is not supported yet.
if [ "$1" != "--catala" ] && [ "$1" != "--castellano" ]; then
	echo "Error: the language introduced is not suported yet. The suported languages are listed below:"
	echo "  + Catalan(--catala)"
	echo "  + Spanish(--castellano)"
	exit 1
fi

# Starting the configuration
echo "Automatic configuration and personalization of Fedora i3wm. You might be prompted for your password at least once."

newline

echo "  + Deleting  previous installation log files..."
file="installation.log"
if [ -f "$file" ]; then
	rm "$file"
	echo "    Previous installation log file deleted."
else
	echo "    No previous installation log file found. "
fi

newline

echo "  + Updating and upgrading the system...."

sudo dnf update -y 2>&1 >>"$file" && sudo dnf upgrade -y 2>&1 >>"$file"

newline

if [ "$1" == "--catala" ]; then
	devtools="Eines de desenvolupament"
	devtoolsc="Eines i biblioteques de desenvolupament amb C"
	images="~/Imatges"
elif [ "$1" == "--castellano" ]; then
	devtools="Herramientas de desarrollo"
	devtoolsc="Herramientas y Librerías de Desarrollo en C"
	images="~/Imágenes"
fi

echo "  + Installing developing tools..."
sudo dnf groupinstall "$devtools" -y 2>&1 >>"$file" && dnf groupinstall "$devtoolsc" -y 2>&1 >>"$file"
sudo dnf install python-pip gfortran neovim nodejs clangd clangd-devel -y 2>&1 >>"$file"
rpm --import https://packages.microsoft.com/keys/microsoft.asc
sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
sudo dnf check-update -y 2>&1 >>"$file" && sudo dnf install code -y 2>&1 >>"$file"
pip install fpm fortls pyright 2>&1 >>"$file"

newline

#echo "  + Installing Graphic card driver..."
#
#sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm -y 2>&1 >> "$file"
#sudo dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y 2>&1 >> "$file"
#sudo dnf update -y 2>&1 >> "$file"
#sudo dnf install akmod-nvidia -y 2>&1 >> "$file"
#sudo dnf install xorg-x11-drv-nvidia-cuda -y 2>&1 >> "$file"

newline

echo "  + Installing other tools..."
sudo dnf install ffmpeg --allowerasing -y 2>&1 >>"$file"
sudo dnf install rofi -y 2>&1 >>"$file"
sudo dnf install fzf -y 2>&1 >>"$file"
sudo dnf install xclip -y 2>&1 >>"$file"
sudo dnf install fish -y 2>&1 >>"$file"
sudo dnf install terminology -y 2>&1 >>"$file"
sudo dnf install feh -y 2>&1 >>"$file"

newline

echo "  + Configuring the system..."

# Lazy vim
git clone https://github.com/LazyVim/starter ~/.config/nvim 2>&1 >>"$file"
rm -rf ~/.config/nvim/.git 2>&1 >>"$file"

# Wallpaper
cp -r Wallpapers "$images" 2>&1 >>"$file"
mkdir -p "~/.config" 2>&1 >>"$file"
mkdir -p "~/.local/share" 2>&1 >>"$file"
cp -r .config/* ~/.config/ 2>&1 >>"$file"
cp -r .bashrc ~/ 2>&1 >>"$file"
cp -r .local/share/* ~/.local/share/nvim/ 2>&1 >>"$file"

newline

echo "Configuration finished."

read -p "Press any key to finish..."
