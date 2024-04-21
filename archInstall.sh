#!/bin/bash


usage() {
    echo "Usage: $0 [options]"
    echo "Options:"
    echo "  -h, --help"
    printf "  -v, --version\n"
    echo "  -e part, --efi  part"
    echo "  -s part, --swap part"
    printf "  -r part, --root part\n"
    echo "  -ws, --wipe-swap"
    printf "  -we, --wipe-efi\n"
    echo "  -nv, --nvidia      Properly install proprietary nvidia driver"
    echo "  -ps, --power-save  Enable powersaving utilities for a laptop"
}

version() {
    echo "$0 v0.1"
}


setfont ter-128b
echo ":: Archlinux install script ::"

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
        *)
            echo "Unknown option: $1"
            usage
            exit 1
            ;;
    esac
    shift
done

if [ -z "$EFI" ] || [ -z "$SWAP" ] || [ -z "$ROOT" ]; then
    echo "Specify partitions"
    usage
    exit 1
fi


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

echo ":: Updating mirrors ..."
reflector \
    -c Russia,Finland \
    --latest 10 \
    --sort rate \
    --save /etc/pacman.d/mirrorlist


pacstrap -K /mnt base linux-zen linux-zen-headers linux-firmware git \
    networkmanager zsh

if [ -n "$NVIDIA_PARAM" ]; then
    pacstrap -G /mnt nvidia-dkms
    sed -i 's/^MODULES=().*/MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)/' \
        /etc/mkinitcpio.conf
    mkinitcpio -P
    echo "options nvidia-drm modeset=1" >> /etc/modprobe.d/nvidia.conf
fi

genfstab -U /mnt >> /mnt/etc/fstab


ln -sf /mnt/usr/share/zoneinfo/Europe/Moscow /mnt/etc/localtime
arch-chroot /mnt hwclock --systohc

echo "en_US.UTF-8 UTF-8" >> /mnt/etc/locale.gen
echo "ru_RU.UTF-8 UTF-8" >> /mnt/etc/locale.gen
arch-chroot /mnt locale-gen
echo "LANG=en_US.UTF-8" > /mnt/etc/locale.conf
echo $HOSTNAME > /mnt/etc/hostname
echo ":: Enter root password"
arch-chroot /mnt passwd

echo "%wheel ALL=(ALL:ALL) ALL" >> /mnt/etc/sudoers
arch-chroot /mnt useradd -m -G wheel -s /usr/bin/zsh nikita
echo ":: Enter user password"
arch-chroot /mnt passwd nikita

efibootmgr --create \
    --disk /dev/$(lsblk -ndo pkname $EFI) \
    --part $(echo $EFI | sed "s/[^0-9]*//") \
    --label "Arch Linux" \
    --loader /vmlinuz-linux-zen \
    --unicode "root=LABEL=arch rw loglevel=3 quiet $NVIDIA_PARAM initrd=\initramfs-linux-zen.img"


