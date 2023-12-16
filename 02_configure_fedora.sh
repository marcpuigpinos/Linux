#!/bin/echo
#
# Installing rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Installing lunar vim
LV_BRANCH='release-1.3/neovim-0.9' bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.3/neovim-0.9/utils/installer/install.sh)

# Add to bashrc oh-my-posh initialization and tab prediction

echo 'eval "$(oh-my-posh init bash --config ~/.cache/oh-my-posh/themes/slim.omp.json)"' >> ~/.bashrc

echo 'bind TAB:menu-complete' >> ~/.bashrc

# download the configuration files from git.
mkdir configuration_from_git
cd configuration_from_git
git clone https://github.com/marcpuigpinos/Linux.git
cp .vimrc ~/.vimrc
cp -r i3 ~/.config/i3
cp -r i3status ~/.config/i3status
cp -r lvim ~/.config/lvim
cd ..
rm -rf configuration_from_git
