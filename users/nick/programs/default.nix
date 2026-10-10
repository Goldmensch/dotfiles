{ ... }: {
  imports = [
    ./git.nix
    ./gpg.nix
    ./yazi.nix
    ./firefox.nix
    ./direnv.nix
    ./ssh.nix
    ./nvim.nix
    ../../../modules/home-manager/programs/yazi.nix
    ./kitty.nix
    ../../../modules/home-manager/programs/zsh.nix
  ];

  programs = {
    home-manager.enable = true;
    starship.enable = true;
  };
}
