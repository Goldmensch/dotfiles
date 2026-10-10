{
  hardware.printers = {
    ensurePrinters = [
      {
        name = "HP_Color_LaserJet";
        location = "home";
        deviceUri = "ipp://192.168.178.28/ipp";
        model = "everywhere";
      }
    ];

    ensureDefaultPrinter = "HP_Color_LaserJet";
  };
}
