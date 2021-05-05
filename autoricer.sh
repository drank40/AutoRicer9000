#!/bin/bash
if [[ "$(whoami)" != root ]]; then
  echo "This script is meant to be run as root right after install."
  exit 1
fi
pacman -S --noconfirm --quiet cowsay
INTRO="Welcome to autoricer9000. You should run this script after installing arch and you'll be able to create a user, have sudo, install graphic drivers, xorg, and dwm."

cowsay $INTRO
echo "What would you like your user to be called?"
read USERNAME
useradd -mg wheel $USERNAME
echo "Added user $USERNAME"

