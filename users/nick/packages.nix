{ pkgs, ... }:
{
  home.packages = with pkgs; [
    thunderbird

    parted

    discord
    librepods

    htop
    git
    wget
    karere

    starship

    gparted

    zip
    unzip

    jetbrains.idea
  ];
}
