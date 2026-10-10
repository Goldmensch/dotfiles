{
  imports = [
    ../../modules/nixos/base/flake_lix.nix
    ../../modules/users/homie.nix
    ./disko_ssd.nix
    ../../modules/nixos/locale/de_DE.nix
    ./services
    ./secrets.nix
  ];

  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "no";
  };

  networking = {
    hostName = "homeserver";

    useNetworkd = true;
    firewall.allowedUDPPorts = [ 5353 ];
  };

  systemd.network.networks = {
    "99-ethernet-default-dhcp".networkConfig.MulticastDNS = "yes";
  };

  system.stateVersion = "26.06";
}
