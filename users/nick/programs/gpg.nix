{
  programs.gpg = {
    enable = true;
    publicKeys = [
      {
        source = ../keys/yubikey.asc;
        trust = 5;
      }
    ];
  };

  services = {
    gpg-agent = {
      enable = true;
      enableSshSupport = true;
      enableScDaemon = true;
    };
  };
}
