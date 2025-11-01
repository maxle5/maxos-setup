#!/usr/bin/env bash

##########################################
# Configure/Install base environment     #
##########################################

# install yay
paru -S yay-bin --noconfirm

# install base packages
yay -S sddm uwsm hyprland hyprlock hyprpaper hypridle hyprpolkitagent hyprpicker hyprshot hyprsunset --noconfirm

# configure sddm
echo -e "[General]\nSession=hyprland-uwsm" | tee -a /etc/sddm.conf

# enable sddm service
systemctl enable sddm
