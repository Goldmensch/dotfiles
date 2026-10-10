{ ... }: {
  imports = [
    ./git.nix
    ./gpg.nix
    ./zsh.nix
    ./firefox.nix
    ./direnv.nix
    ./ssh.nix
    ./nvim.nix
    ./yazi.nix
    ./kitty.nix
  ];

  programs = {
    home-manager.enable = true;
    starship.enable = true;
  };
}
