{
  imports = [
    ../../../modules/nixos/bootloader/limine.nix
    ../default.nix
    ./hardware.nix
  ];

  networking.hostName = "roberto";
  system.stateVersion = "23.06";
}
