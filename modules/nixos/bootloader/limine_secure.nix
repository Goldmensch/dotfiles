{
  imports = [
    ./limine.nix
  ];

  boot.loader.limine.secureBoot = {
    enable = true;
    autoGenerateKeys = true;
  };
}
