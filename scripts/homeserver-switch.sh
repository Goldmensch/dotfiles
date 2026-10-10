#!/bin/sh

nixos-rebuild switch \
  --flake /home/nick/dotfiles#homeserver \
  --target-host homie@homeserver \
  --ask-sudo-password \
  --sudo
