{ pkgs, ... }: {
  home.packages = with pkgs; [
    htop
    zip
    unzip
  ];
}
