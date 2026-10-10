{
  imports = [
    ../../../modules/nixos/bootloader/limine_secure.nix
    ../default.nix
    ./hardware.nix
  ];

  networking.hostName = "roberto";
  system.stateVersion = "23.06";
}
