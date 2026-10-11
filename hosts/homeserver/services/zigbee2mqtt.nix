{ config, ... }: {
  services.zigbee2mqtt = {
    enable = true;
    settings = {
      homeassistant.enabled = true;
      frontend = {
        enable = true;
        port = 8080;
      };

      mqtt = {
        server = "mqtt:localhost";
        user = "hass";
        password = "!${config.age.secrets."mosquitto-hass-pw.yaml".path} pw";
        base_topic = "zigbee2mqtt";
      };

      serial.port = "/dev/ttyACM0";

      advanced = {
        transmit_power = 127;
        channel = 25;
      };
    };
  };

  networking.firewall.allowedTCPPorts = [
    8080
  ];
}
