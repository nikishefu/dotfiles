#!/bin/bash


usage() {
    echo "Usage: $0 [options]"
    echo "Options:"
    echo "  -h, --help"
    echo "  -v, --version\n"
    echo "  -e part, --efi  part"
    echo "  -s part, --swap part"
    echo "  -r part, --root part\n"
    echo "  -ws, --wipe-swap"
    echo "  -we, --wipe-efi\n"
    echo "  -nv, --nvidia      Properly install proprietary nvidia driver"
    echo "  -ps, --power-save  Enable powersaving utilities for a laptop"
}

version() {
    echo "$0 v0.1"
}


setfont ter-128b
echo ":: Welcome to archlinux install script by nikishefu ::"

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
        -e|--efi)
            shift
            EFI=$1
            ;;
        -s|--swap)
            shift
            SWAP=$1
            ;;
        -r|--root)
            shift
            ROOT=$1
            ;;
        -ws|--wipe-swap)
            WIPE_SWAP=1
            ;;
        -we|--wipe-efi)
            WIPE_EFI=1
            ;;
        -nv|--nvidia)
            NVIDIA_PARAM="nvidia_drm.modeset=1"
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



set -e


if [ $(cat /sys/firmware/efi/fw_platform_size) -eq 64 ]; then
    echo ":: UEFI is 64 bit"
else
    echo "!: 64 bit UEFI is required, exiting"
    exit 1
fi

timedatectl set-timezone Europe/Moscow
timedatectl

if [ -n "$WIPE_EFI" ];  then mkfs.fat -F 32 $EFI; fi
if [ -n "$WIPE_SWAP" ]; then mkswap $SWAP; fi
mkfs.ext4 -L arch $ROOT

mount $ROOT /mnt
mount --mkdir $EFI /mnt/boot
swapon $SWAP

reflector \
    -c Russia,Finland \
    --latest 10 \
    --sort rate \
    --save /etc/pacman.d/mirrorlist

pacstrap -K /mnt base linux-zen linux-zen-headers linux-firmware \
    amd-ucode base-devel bind blueberry bluez bluez-utils brightnessctl \
    capitaine-cursors chromium cmake cpio cpupower discord efibootmgr \
    fastfetch firefox gamescope gimp git gnome-calculator go grim htop \
    hyprland imagemagick inkscape inxi kitty krita lib32-libva-mesa-driver \
    lib32-vulkan-radeon libmpeg2 libreoffice-still libva-mesa-driver \
    libva-utils mako meson networkmanager noto-fonts neovim thunar \
    noto-fonts-cjk noto-fonts-emoji nvtop nwg-look obs-studio udiskie \
    waybar pipewire wireplumber vulkan-radeon telegram-desktop zip zsh\
    swappy slurp sudo steam sddm sdbus-cpp ripgrep qbittorrent \
    pipewire-pulse pipewire-jack pipewire-alsa polkit-kde-agent \
    papirus-icon-theme pavucontrol otf-hermit-nerd ttf-inconsolata-nerd \
    openssh qemu-full qt5ct qt5-graphicaleffects qt5-wayland qt6ct \
    qt6-wayland vlc xdg-desktop-portal-hyprland

if [ -n "$NVIDIA_PARAM" ]; then
    pacstrap -G /mnt nvidia-dkms
    sed -i 's/^MODULES=().*/MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)/' \
        /etc/mkinitcpio.conf
    mkinitcpio -P
    echo "options nvidia-drm modeset=1" >> /etc/modprobe.d/nvidia.conf
fi
if [ -n "$POWERSAVE" ]; then pacstrap -G /mnt tlp; fi

genfstab -U /mnt >> /mnt/etc/fstab

arch-chroot /mnt

ln -sf /usr/share/zoneinfo/Europe/Moscow /etc/localtime
hwclock --systohc

echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
echo "ru_RU.UTF-8 UTF-8" > /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo $HOSTNAME >> /etc/hostname
echo ":: Enter root password"
passwd

echo "%wheel ALL=(ALL:ALL) ALL" > /etc/sudoers
useradd -m -G wheel -s /usr/bin/zsh nikita
echo ":: Enter user password"
passwd nikita

efibootmgr --create \
    --disk /dev/$(lsblk -ndo pkname $EFI) \
    --part $(echo $EFI | sed "s/[^0-9]*//") \
    --label "Arch Linux" \
    --loader /vmlinuz-linux-zen \
    --unicode "root=LABEL=arch rw loglevel=3 quiet $NVIDIA_PARAM initrd=\initramfs-linux-zen.img"

