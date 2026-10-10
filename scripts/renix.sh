#!/bin/sh

sudo nixos-rebuild switch --flake /home/nick/dotfiles#$(hostname) --accept-flake-config && sudo systemctl restart home-manager-nick.service
