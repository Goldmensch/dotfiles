{pkgs, ...}:

let
  better-minimalistic-area-card =
    pkgs.callPackage ./packages/lovelace/better-minimalistic-area-card.nix {};
in
{
    # because of test errors
    nixpkgs.overlays = [
        (final: prev: {
        pythonPackagesExtensions =
            prev.pythonPackagesExtensions
            ++ [
                (python-final: python-prev: {
                    paho-mqtt = python-prev.paho-mqtt.overridePythonAttrs (old: {
                    doCheck = false;
                    });
                })
            ];
        })
    ];

     networking.firewall.allowedTCPPorts = [
         8123
     ];

    services.home-assistant = {
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

        customLovelaceModules = with pkgs.home-assistant-custom-lovelace-modules; [
          mini-media-player
          mushroom
          vacuum-card
        ] ++ [
          better-minimalistic-area-card
        ];

        config = {
            default_config = {};

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


