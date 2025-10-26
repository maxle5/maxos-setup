#!/usr/bin/env bash

# install base packages
sudo pacman -S sddm uwsm hyprland hyprlock hyprpaper hypridle hyprpolkitagent hyprpicker hyprshot hyprsunset --noconfirm

# configure sddm
echo -e "[General]\nSession=hyprland-uwsm" | sudo tee -a /etc/sddm.conf

# enable sddm service
sudo systemctl enable sddm
