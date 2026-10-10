{ pkgs, ... }:
{
  home.packages = with pkgs; [
    efibootmgr
    sbctl

    thunderbird

    parted

    discord
    librepods

    htop
    git
    wget
    karere

    starship
    alacritty

    gparted

    zip
    unzip

    jetbrains.idea
  ];
}
