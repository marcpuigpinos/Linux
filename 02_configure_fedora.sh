#!/bin/echo
#
curl -s https://ohmyposh.dev/install.sh | bash -s -- -d ~/.local/bin
mkdir -p fonts
cd fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/Hack.zip
mkdir -p ~/.local/share/fonts
cp Hack.zip ~/.local/share/fonts
unzip ~/.local/share/fonts/Hack.zip
cd ..
rm -rf fonts

# Installing rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source ~/.bashrc

# Installing lunar vim
LV_BRANCH='release-1.3/neovim-0.9' bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.3/neovim-0.9/utils/installer/install.sh)

# Add to bashrc oh-my-posh initialization and tab prediction

echo 'eval "$(oh-my-posh init bash --config ~/.cache/oh-my-posh/themes/takuya.omp.json)"' >> ~/.bashrc

echo 'bind TAB:menu-complete' >> ~/.bashrc

# download the configuration files from git.
cp .vimrc ~/.vimrc
mkdir -p ~/.config/i3
mkdir -p ~/.config/i3status
mkdir -p ~/.config/lvim
cp -r i3/config ~/.config/i3/config
cp -r i3status/config ~/.config/i3status/config
cp -r lvim ~/.config/lvim
chmod +x ~/.config/i3/volume_control.sh
cp -r polybar ~/.config/polybar
cp -r rofi-wifi-menu ~/.config/rofi-wifi-menu
cp -r polybar-bluetooth ~/.config/polybar-bluetooth
chmod +x ~/.config/rofi-wifi-menu/rofi-wifi-menu.sh
chmod +x ~/.config/polybar-bluetooth/bluetooth.sh
chmod +x ~/.config/polybar-bluetooth/toggle_bluetooth.sh
chmod +x ~/.config/polybar/launch.sh
cp -r picom.conf ~/.config/
cp -r fish ~/.config/
