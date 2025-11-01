#!/usr/bin/env bash

##########################################
# Install/Configure "SDKs"               #
##########################################

yay -S dotnet-sdk-8.0-bin \
    --noconfirm

fnm install 22.20.0
fnm default 22.20.0
