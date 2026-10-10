{ pkgs, ... }: {
  systemd.services.cups.serviceConfig = {
    Restart = "on-failure";
    RestartSec = "10s";
    StartLimitIntervalSec = 0;
  };

  services = {
    printing = {
      enable = true;
      drivers = with pkgs; [
        cups-filters
        cups-browsed
      ];
    };

    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };
}
