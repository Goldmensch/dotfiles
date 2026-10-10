#!/bin/sh

sudo nixos-rebuild switch --flake /home/nick/dotfiles#$(hostname)&& sudo systemctl restart home-manager-nick.service
