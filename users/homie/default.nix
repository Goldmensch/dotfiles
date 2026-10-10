{ lazyvim, ... }: {
  imports = [
    lazyvim.homeManagerModules.default

    ./packages.nix
    ../../modules/home-manager/programs/yazi.nix
    ../../modules/home-manager/programs/nvim.nix
    ../../modules/home-manager/programs/zsh.nix
  ];

  home = {
    username = "homie";
    homeDirectory = "/home/homie";

    keyboard.layout = "eu";

    stateVersion = "23.11";
  };
}
