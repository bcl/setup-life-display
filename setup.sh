#!/bin/bash

# SD card /boot partition must be mounted on $1

[ -z "$1" ] && { echo "Usage: $0 <root-path>"; exit 1; }
[ -e "$1/boot" -a -e "$1/root" ] || { echo "boot or root is missing from $1"; exit 1; }

ROOT=$1
# Enable ssh
touch $ROOT/boot/ssh
cp ./configs/wpa_supplicant.conf $ROOT/boot/
cp ./configs/userconf $ROOT/boot/
cp ./configs/config.txt $ROOT/boot/
cp ./configs/issue $ROOT/root/etc/issue

# Check out the sdl2-life source
mkdir $ROOT/root/opt/
cd $ROOT/root/opt/
GIT_SSL_NO_VERIFY=true git clone https://github.com/bcl/sdl2-life.git

echo "SETUP YOUR AP IN $ROOT/boot/wpa_supplicant.conf"
