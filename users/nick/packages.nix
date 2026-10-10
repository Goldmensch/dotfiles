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

    gparted

    zip
    unzip

    jetbrains.idea
  ];
}
