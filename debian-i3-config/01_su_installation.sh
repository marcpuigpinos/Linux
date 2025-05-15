#!/bin/bash

echo "Installing debian"

apt update -y
apt install build-essential git cmake meson xorg xdm i3 dmenu pulseaudio pavucontrol firefox-esr emacs network-manager texlive pandoc bat fzf paraview libreoffice alacritty thunar xclip 7zip network-manager-gnome htop blueman -y

# Check if /bin/python3 exists and /bin/python does not
if [ -f /bin/python3 ] && [ ! -e /bin/python ]; then
    echo "Creating symbolic link: /bin/python -> /bin/python3"
    ln -s /bin/python3 /bin/python
else
    echo "No action taken."
    if [ ! -f /bin/python3 ]; then
        echo "/bin/python3 does not exist."
    fi
    if [ -e /bin/python ]; then
        echo "/bin/python already exists."
    fi
fi

# Check if /bin/batcat exists and /bin/bat does not
if [ -f /bin/batcat ] && [ ! -e /bin/bat ]; then
    echo "Creating symbolic link: /bin/bat -> /bin/batcat"
    ln -s /bin/python3 /bin/python
else
    echo "No action taken."
    if [ ! -f /bin/batcat ]; then
        echo "/bin/batcat does not exist."
    fi
    if [ -e /bin/bat ]; then
        echo "/bin/bat already exists."
    fi
fi

echo "Installing Oh-my-bash
bash -c "$(wget https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh -O -)"
