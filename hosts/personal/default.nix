{
  imports = [
    ../../modules/nixos/base/flake_lix.nix
    ../../modules/nixos/locale/de_DE.nix
    ../../modules/nixos/sound/default.nix
    ../../modules/nixos/yubikey
    ../../modules/users/nick.nix
    ../../modules/nixos/bootloader/limine.nix
    ../../modules/nixos/cosmic
    ../../modules/nixos/printing
    ../../modules/nixos/printing/home_hp_printer.nix
  ];
}
