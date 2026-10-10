{ pkgs, ... }: {
  programs.lazyvim = {
    enable = true;
    extras = {
      lang.nix.enable = true;
    };

    extraPackages = with pkgs; [
      nixd
      nixfmt
      statix
    ];
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };
}
