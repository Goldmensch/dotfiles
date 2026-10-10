{ ... }: {
  imports = [
    ./git.nix
    ./gpg.nix
    ./zsh.nix
    ./firefox.nix
    ./direnv.nix
    ./ssh.nix
    ./vim.nix
  ];

  programs = {
    home-manager.enable = true;
    starship.enable = true;
  };
}
