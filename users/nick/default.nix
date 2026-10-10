{ lazyvim, ... }: {
  imports = [
    lazyvim.homeManagerModules.default

    ./packages.nix
    ./programs
  ];

  home = {
    username = "nick";
    homeDirectory = "/home/nick";

    keyboard.layout = "eu";

    stateVersion = "23.11";
  };
}
