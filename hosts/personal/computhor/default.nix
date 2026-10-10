{
  imports = [
    ../../../modules/nixos/bootloader/limine.nix
    ../default.nix
    ./hardware.nix
    ../../../modules/nixos/wol/default.nix
  ];

  boot.binfmt.emulatedSystems = [
    "aarch64-linux"
  ];

  networking.hostName = "computhor";
  system.stateVersion = "23.06";
}
