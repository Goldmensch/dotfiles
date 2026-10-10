{
  boot.loader = {
    efi.canTouchEfiVariables = true;
    limine = {
      enable = true;
      efiSupport = true;
      maxGenerations = 10;

      extraEntries = ''
        /Windows
          protocol: efi_boot_entry
          entry: Windows Boot Manager
      '';
    };
  };
}
