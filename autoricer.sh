#!/bin/bash
if [[ "$(whoami)" != root ]]; then
  echo "This script is meant to be run as root right after install."
  exit 1
fi
pacman -S --noconfirm --quiet cowsay
INTRO="Welcome to autoricer9000. You should run this script after installing arch and you'll be able to create a user, have sudo, install graphic drivers, yay, xorg, and dwm."

cowsay $INTRO
echo "What would you like your user to be called?"
read USERNAME
useradd -mg wheel $USERNAME
echo "Added user $USERNAME"
echo '$USERNAME  ALL=(ALL:ALL) ALL' >> /etc/sudoers
echo "Installing video drivers..."
if [[ "$(lspci | grep VGA | grep NVIDIA)" != "" ]]; then
	pacman -S --noconfirm --quiet nvidia
fi

echo "Setting up AUR helper."
cd /opt 
sudo git clone https://aur.archlinux.org/yay-git.git
sudo chown -R $USERNAME ./yay-git
cd yay-git
sudo -u $USERNAME -H sh -c "makepkg -si"
sudo -u $USERNAME -H sh -c "yay -S adobe-source-code-pro-fonts ttf-font-awesome xorg-server xorg-xinit xorg-xrdb xorg-xsetroot xorg-setxkbmap xcompmgr libxinerama feh lm_sensors autocutsel pulseaudio"

