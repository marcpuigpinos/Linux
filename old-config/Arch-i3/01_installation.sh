#!/bin/bash
set -euo pipefail
LOGFILE="$HOME/arch-setup.log"
exec > >(tee -a "$LOGFILE") 2>&1

# COLORS
GREEN='\033[1;32m'
RED='\033[1;31m'
NC='\033[0m'

# Helper Functions
print_info() {
    echo -e "${GREEN}==> $1${NC}"
}

print_error() {
    echo -e "${RED}Error: $1${NC}" >&2
}

check_internet() {
    print_info "Checking internet connectivity..."
    if ! ping -c 1 archlinux.org &>/dev/null; then
        print_error "No internet connection."
        exit 1
    fi
}

check_sudo() {
    if [[ $EUID -ne 0 ]]; then
        print_error "Please run this script with sudo or as root."
        exit 1
    fi
}

# MAIN SETUP
main() {
    check_internet
    check_sudo

    print_info "Updating system..."
    pacman -Syu --noconfirm

    # Safe orphan removal
    print_info "Checking for orphaned packages..."
    orphans=$(pacman -Qdtq || true)
    if [[ -n "$orphans" ]]; then
        print_info "Removing orphans: $orphans"
        pacman -Rns $orphans --noconfirm
    else
        print_info "No orphaned packages found."
    fi

    # Base packages
    BASE_PACKAGES=(
        xorg-xrandr arandr brightnessctl base-devel pavucontrol gvfs thunar xclip
        git bat fzf emacs gcc-fortran python-pip alacritty texlive-most htop
        blueman bluez bluez-utils cmake meson feh os-prober grub man-db
        xdg-user-dirs
    )

    print_info "Installing base packages..."
    pacman -S --noconfirm "${BASE_PACKAGES[@]}"

    # Enable Bluetooth
    print_info "Enabling Bluetooth service..."
    systemctl enable --now bluetooth

    # Create user directories
    print_info "Setting up XDG user directories..."
    sudo -u "$SUDO_USER" xdg-user-dirs-update

    print_info "Setup complete. Log saved to $LOGFILE"
}

main

