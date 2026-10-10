let
  de = "de_DE.UTF-8";
in
{
  time.timeZone = "Europe/Berlin";

  i18n = {
    defaultLocale = de;

    extraLocaleSettings = {
      LC_ADDRESS = de;
      LC_IDENTIFICATION = de;
      LC_MEASUREMENT = de;
      LC_MONETARY = de;
      LC_NAME = de;
      LC_NUMERIC = de;
      LC_PAPER = de;
      LC_TELEPHONE = de;
      LC_TIME = de;
      LC_COLLATE = de;
    };
  };
}
