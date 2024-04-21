#!/bin/bash

usage() {
    echo "Usage: $0 [options]"
    echo "Options:"
    echo "  -h, --help"
    printf "  -v, --version\n"
    echo "  -nv, --nvidia      Properly install proprietary nvidia driver"
    echo "  -ps, --power-save  Enable powersaving utilities for a laptop"
}

version() {
    echo "$0 v0.1"
}


setfont ter-128b
echo ":: Archlinux configuration ::"

while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            usage
            exit 0
            ;;
        -v|--version)
            version
            exit 0
            ;;
        -nv|--nvidia)
            NVIDIA=1
            ;;
        -ps|--power-save)
            POWERSAVE=1
            ;;
        *)
            echo "Unknown option: $1"
            usage
            exit 1
            ;;
    esac
    shift
done

mkdir -p ~/.config
cp -r ./* ~/.config


# SUDO SECTION
su -

printf "[multilib]\nInclude = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf

pacman -Syu --needed amd-ucode base-devel bind blueberry bluez bluez-utils \
    brightnessctl capitaine-cursors chromium cmake cpio cpupower discord \
    efibootmgr fastfetch firefox gimp git gnome-calculator go grim \
    htop hyprland imagemagick inkscape inxi kitty krita lib32-libva-mesa-driver \
    lib32-vulkan-radeon libmpeg2 libreoffice-still libva-mesa-driver \
    libva-utils mako meson networkmanager noto-fonts neovim thunar \
    noto-fonts-cjk noto-fonts-emoji nvtop nwg-look obs-studio udiskie \
    waybar pipewire wireplumber vulkan-radeon telegram-desktop zip zsh\
    swappy slurp sudo steam sddm sdbus-cpp ripgrep qbittorrent \
    pipewire-pulse pipewire-jack pipewire-alsa polkit-kde-agent \
    papirus-icon-theme pavucontrol otf-hermit-nerd ttf-inconsolata-nerd \
    openssh qemu-full qt5ct qt5-graphicaleffects qt5-wayland qt6ct \
    qt6-wayland vlc xdg-desktop-portal-hyprland linux-zen-headers

if [ -n "$POWERSAVE" ]; then
    pacman -S tlp
fi

if [ -n "$NVIDIA" ]; then
    system76-power daemon &
    system76-power graphics nvidia
    system76-power profile performance
    systemctl enable com.system76.PowerDaemon
else
    pacman -S gamescope
fi

systemctl enable sddm
timedatectl set-ntp true


# USER SECTION
logout

git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si

yay -Sy nvim-packer-git tgpt-bin tofi anydesk-bin mkinitcpio-firmware termius \
    rose-pine-hyprcursor swayosd-git opentabletdriver

if [ -n "$POWERSAVE" ]; then
    yay -S auto-epp
fi

if [ -n "$NVIDIA" ]; then
    yay -S system76-power gamescope-nvidia
fi

