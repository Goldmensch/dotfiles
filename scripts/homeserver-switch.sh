#!/bin/sh

nixos-rebuild switch \
  --flake /home/nick/dotfiles#homeserver \
  --accept-flake-config \
  --target-host homie@homeserver \
  --ask-sudo-password \
  --sudo
