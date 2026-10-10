{ pkgs, ... }: {
  imports = [
    ../home-manager/default.nix
    ./default.nix
  ];
  programs.zsh.enable = true;

  users.users.homie = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
    shell = pkgs.zsh;
    hashedPassword = "$y$j9T$ATjsOx5in3cz8Xt723eGx/$5lQEnDc4wDFzoVZNezwk7e6WEKLqvzdZvswT/tq/Pc.";
  };

  home-manager.users.homie = {
    imports = [
      ../../users/homie
    ];
  };

  nix.settings.trusted-users = [ "homie" ];

}
