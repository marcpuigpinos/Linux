#!/bin/bash

# Function to install Nvidia drivers
install_nvidia() {
  # Add commands to install Nvidia drivers here
  sudo dnf install akmod-nvidia -y
  #sudo dnf install xorg-x11-drv-nvidia-cuda -y
}

# Function to install AMD drivers
install_amd() {
  # Add commands to install AMD drivers here
  echo "Not implemented yet"
}

# Function to display the help message
display_help() {
  echo "Usage: $0 [options]"
  echo
  echo "Options:"
  echo "  --install-graphic-card nvidia    Install Nvidia graphic card drivers"
  echo "  --install-graphic-card amd       Install AMD graphic card drivers"
  echo "  --help                           Display this help message"
  echo
  echo "Example:"
  echo "  $0 --install-graphic-card nvidia"
  echo "  $0 --install-graphic-card amd"
  echo "  $0"
}

# Parse command-line arguments
while [[ "$#" -gt 0 ]]; do
  case $1 in
  --install-graphic-card)
    if [[ -n "$2" && "$2" != "--"* ]]; then
      GRAPHIC_CARD="$2"
      shift
    else
      echo "Error: --install-graphic-card requires an argument: 'nvidia' or 'amd'"
      exit 1
    fi
    ;;
  --help)
    display_help
    exit 0
    ;;
  *)
    echo "Unknown option: $1"
    display_help
    exit 1
    ;;
  esac
  shift
done

# Main script logic
if [[ "$GRAPHIC_CARD" == "nvidia" ]]; then
  echo "Installing Nvidia drivers..."
elif [[ "$GRAPHIC_CARD" == "amd" ]]; then
  echo "Installing AMD drivers..."
elif [[ -z "$GRAPHIC_CARD" ]]; then
  echo "No graphic card drivers will be installed."
else
  echo "Invalid option for --install-graphic-card: $GRAPHIC_CARD. Valid options are 'nvidia' or 'amd'."
  display_help
  exit 1
fi

echo "You might be asked for password more than one time..."
sudo dnf update -y && sudo dnf upgrade -y && sudo dnf clean all -y
sudo dnf install gcc -y
sudo dnf install g++ -y
sudo dnf install cmake -y
sudo dnf install git -y
sudo dnf install bat -y
sudo dnf install xclip -y
sudo dnf install python-pip -y
sudo dnf install gfortran -y
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm -y
sudo dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y
sudo dnf update -y
if [[ "$GRAPHIC_CARD" == "nvidia" ]]; then
  install_nvidia
elif [[ "$GRAPHIC_CARD" == "amd" ]]; then
  install_amd
elif [[ -z "$GRAPHIC_CARD" ]]; then
  echo "No graphic card drivers will be installed."
fi
sudo dnf install neovim -y
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo >/dev/null
sudo dnf check-update -y
sudo dnf install code -y
sudo dnf install paraview -y
sudo dnf install texlive -y
sudo dnf install fzf -y
sudo dnf install 

mkdir -p fonts
cd fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/ComicShannsMono.zip
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/Hack.zip
mkdir -p ~/.local/share/fonts
unzip ComicShannsMono.zip
unzip Hack.zip
cp * ~/.local/share/fonts
cd ..
rm -rf fonts

cp .alacritty.toml ~/.alacritty.toml

# Install Oh-my-bash
( bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)" )

# Copy configuration files
cp .bashrc ~/.bashrc

## Lazyvim installation
#mv ~/.config/nvim{,.bak}
#mv ~/.local/share/nvim{,.bak}
#mv ~/.local/state/nvim{,.bak}
#mv ~/.cache/nvim{,.bak}
#git clone https://github.com/LazyVim/starter ~/.config/nvim
#git clone https://github.com/LazyVim/starter ~/.config/nvim
#
## Lazyvim custom config
#cp custom.lua ~/.config/nvim/lua/config/custom.lua
#cp init.lua ~/.config/nvim/init.lua

source .bashrc

echo "Installation finished!"

echo "To have the custom keyboard shortcuts, do not forget to import file keyboard-Shortcuts.kksrc from keyboar/shortcuts preferences."
