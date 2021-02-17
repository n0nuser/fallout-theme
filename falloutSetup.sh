#!/bin/bash

# Author: n0nuser
# Repository: https://github.com/n0nuser/Bash-scripts

# Description:
# Allows to set the Fallout theme in a new fresh new installation (or not) of any apt-managed OS
# Tested in Ubuntu 20.04

# References:
# - Grub: https://github.com/shvchk/fallout-grub-theme.git
# - Plymouth: https://www.gnome-look.org/p/1259515
# - Background: https://www.deviantart.com/gorillazxd/art/Fallout-Screen-624115776
# - Login Background Script: https://github.com/thiggy01/change-gdm-background

## UPDATE

sudo apt update -y && sudo apt upgrade -y && sudo apt dist-upgrade -y

sudo apt install -y plymouth git libglib2.0-dev

## INSTALLATION

### GRUB

git clone https://github.com/shvchk/fallout-grub-theme.git grub-theme
cd grub-theme && chmod +x install.sh && ./install.sh && cd ..

### PLYMOUTH

tar -xvf fallout.tar.xz
sudo cp -fr fallout /usr/share/plymouth/themes/
sudo update-alternatives --install /usr/share/plymouth/themes/default.plymouth default.plymouth /usr/share/plymouth/themes/fallout/fallout.plymouth 100
sudo update-alternatives --quiet --set default.plymouth /usr/share/plymouth/themes/fallout/fallout.plymouth
sudo update-initramfs -u

### BACKGROUND

cp falloutWallpaper.png $(xdg-user-dir PICTURES)
command="gsettings set org.gnome.desktop.background picture-uri 'file:///$(xdg-user-dir PICTURES)/falloutWallpaper.png'"
eval $command

### LOGIN BACKGROUND

wget https://github.com/thiggy01/change-gdm-background/raw/master/change-gdm-background
chmod +x change-gdm-background
command2="./change-gdm-background '$(xdg-user-dir PICTURES)/falloutWallpaper.png'"
sudo eval $command2
# To reset: sudo ./change-gdm-background --restore

echo "You can now reboot!"
