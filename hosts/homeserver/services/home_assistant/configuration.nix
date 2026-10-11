{
  pkgs,
  ...
}:

let
  p_lovelace_base = ./../../../../packages/lovelace;

  # usage example:
  # {
  #   better-minimalistic-area-card = { inerhit pkgs; }
  # }
  packageArgs = { };

  lovelace_packages = builtins.listToAttrs (
    builtins.map (
      f:
      let
        name = builtins.replaceStrings [ ".nix" ] [ "" ] f;
      in
      {
        inherit name;
        value = pkgs.callPackage (p_lovelace_base + "/${f}") (packageArgs.${name} or { });
      }
    ) (builtins.attrNames (builtins.readDir p_lovelace_base))
  );
in
{
  networking.firewall.allowedTCPPorts = [
    8123
  ];

  services.home-assistant = {
    package = pkgs.home-assistant;
    enable = true;
    extraComponents = [
      "analytics"
      "google_translate"
      "met"
      "radio_browser"
      "shopping_list"
      "isal"

      "mqtt"
      "zha"
      "tuya"
      "govee_ble"
      "xiaomi_ble"
      "thread"
      "apple_tv"
      "bosch_shc"
      "ipp"

      "androidtv"
      "fritz"
      "samsungtv"
      "ista_ecotrend"
      "lg_thinq"
      "wake_on_lan"
      "idasen_desk"
    ];

    customComponents = with pkgs.home-assistant-custom-components; [
      localtuya
      better_thermostat
    ];

    customLovelaceModules =
      with pkgs.home-assistant-custom-lovelace-modules;
      [
        mini-media-player
        mushroom
        vacuum-card
      ]
      ++ [
        lovelace_packages.better-minimalistic-area-card
        lovelace_packages.better-thermostat-ui-card
      ];

    config = {
      default_config = { };

      frontend.themes = "!include_dir_merge_named themes";
      "automation ui" = "!include automations.yaml";
      "scene ui" = "!include scenes.yaml";
      "script ui" = "!include scripts.yaml";

      http = {
        use_x_forwarded_for = true;
        trusted_proxies = [
          "127.0.0.1"
          "192.168.178.168"
        ];
      };

    };
  };
}
