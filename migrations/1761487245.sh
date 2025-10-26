#!/usr/bin/env bash

# install base packages
pacman -S sddm uwsm hyprland hyprlock hyprpaper hypridle hyprpolkitagent hyprpicker hyprshot hyprsunset --noconfirm

# configure sddm
echo -e "[General]\nSession=hyprland-uwsm" | tee -a /etc/sddm.conf

# enable sddm service
systemctl enable sddm
