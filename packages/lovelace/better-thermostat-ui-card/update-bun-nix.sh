#!/usr/bin/env bash
set -euo pipefail

dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

src="$(nix build \
  --impure \
  --no-link \
  --print-out-paths \
  --expr "
    let
      pkgs = import <nixpkgs> {};
    in
      import ${dir}/source.nix {
        inherit (pkgs) fetchFromGitHub;
      }
  ")"

cp -r "$src"/. "$tmp/"
chmod -R u+w "$tmp"
cd "$tmp"

sed -i 's/, "piitaya-lovelace-mushroom-3f0c3d1"//' bun.lock

echo "Angepasster Eintrag:"
grep -n -A3 '"mushroom-cards":' bun.lock

bun2nix \
  --lock-file "$tmp/bun.lock" \
  --output-file "$dir/bun.nix"
