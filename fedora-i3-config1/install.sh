#!/bin/bash

# Function to install Nvidia drivers
install_nvidia() {
    # Add commands to install Nvidia drivers here
    sudo dnf install akmod-nvidia -y 
    sudo dnf install xorg-x11-drv-nvidia-cuda -y 
}

# Function to install AMD drivers
install_amd() {
    # Add commands to install AMD drivers here
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
sudo dnf update -y && dnf upgrade -y
sudo dnf groupinstall "Herramientas de desarrollo" -y && dnf groupinstall "Herramientas y Librerías de Desarrollo en C" -y
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
else
fi
sudo dnf install ffmpeg --allowerasing -y
sudo dnf install rofi -y
sudo dnf install neovim -y
sudo dnf install nodejs -y
npm install tree-sitter-cli
sudo dnf install ripgrep
sudo dnf copr enable atim/lazygit -y
sudo dnf install lazygit
curl -L https://github.com/dundee/gdu/releases/latest/download/gdu_linux_amd64.tgz | tar xz
chmod +x gdu_linux_amd64
sudo mv gdu_linux_amd64 /usr/bin/gdu
sudo dnf copr enable atim/bottom -y
sudo dnf install bottom
sudo dnf install blueman -y
sudo dnf install polybar -y
sudo dnf install fzf -y
sudo dnf install xclip -y
sudo dnf install picom -y
sudo dnf install fish -y
sudo dnf install alacritty -y
sudo dnf install feh -y
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null
dnf check-update -y
sudo dnf install code -y# or code-insiders
sudo dnf install firejail -y
sudo dnf install gnome-screenshot

mkdir -p ~/.local/bin
curl -s https://ohmyposh.dev/install.sh | bash -s -- -d ~/.local/bin
mkdir -p fonts
cd fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/Hack.zip
mkdir -p ~/.local/share/fonts
unzip Hack.zip
cp * ~/.local/share/fonts
cd ..
rm -rf fonts

# Add to bashrc oh-my-posh initialization and tab prediction
echo 'eval "$(oh-my-posh init bash --config ~/.cache/oh-my-posh/themes/zash.omp.json )"' >> ~/.bashrc
echo 'bind TAB:menu-complete' >> ~/.bashrc

# download the configuration files from git.
cp .alacritty.toml ~/.alacritty.toml
mkdir -p ~/.config/i3
mkdir -p ~/.config/i3status
cp -r i3/config ~/.config/i3/config
cp -r i3/volume_control.sh ~/.config/i3/volume_control.sh
cp -r i3status/config ~/.config/i3status/config
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
mkdir -p ~/.config/gtk-3.0
cp gtk-3.0/settings.ini ~/.config/gtk-3.0/settings.ini
mv Wallpapers ~/Imágenes
git clone --depth 1 https://github.com/AstroNvim/template ~/.config/nvim
rm -rf ~/.config/nvim/.git

echo "vim.opt.tabstop = 4" >> ~/.config/nvim/init.lua
echo "vim.opt.softtabstop = 4" >> ~/.config/nvim/init.lua
echo "vim.opt.shiftwidth = 4" >> ~/.config/nvim/init.lua 
echo "vim.opt.expandtab = True" >> ~/.config/nvim/init.lua 
echo "vim.opt.shell = \"/bin/fish\"" >>  ~/.config/nvim/init.lua 

echo "Installation finished!"
