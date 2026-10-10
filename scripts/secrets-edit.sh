#!/bin/sh

export AGENIX_RULES="/home/nick/dotfiles/secrets/secrets.nix"

file="${1#secrets/}"

agenix --identity /home/nick/dotfiles/secrets/identity/computhor-age.txt -e "$file"
