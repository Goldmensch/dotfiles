{ pkgs, ... }: {
  imports = [
    ../home-manager/default.nix
    ./default.nix
  ];

  programs.zsh.enable = true;

  users.users.nick = {
    isNormalUser = true;
    description = "Nick Hensel";
    extraGroups = [
      "networkmanager"
      "wheel"
      "seat"
    ];
    shell = pkgs.zsh;
    hashedPassword = "$y$j9T$ATjsOx5in3cz8Xt723eGx/$5lQEnDc4wDFzoVZNezwk7e6WEKLqvzdZvswT/tq/Pc.";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEqW5HZq5oU8xBstcyA2JzL2iGZ69Cj6jyAL14p/uPs/ openpgp:0xFBFB79F7"
    ];
  };

  home-manager.users.nick = {
    imports = [
      ../../users/nick
    ];
  };

  services.displayManager.autoLogin = {
    enable = true;
    user = "nick";
  };

  nix.settings.trusted-users = [ "nick" ];
}
