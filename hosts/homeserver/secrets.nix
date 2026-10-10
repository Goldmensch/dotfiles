let
  base = ../../secrets/homeserver;
  r-mode = "0400";
in
{
  age.secrets = {
    mosquitto-hass-pw = {
      file = base + "/mosquitto-hass-pw.age";
      owner = "zigbee2mqtt";
      mode = r-mode;
    };

    cloudflared-token = {
      file = base + "/cloudflared-token.age";
      owner = "cloiudflared";
      mode = r-mode;
    };
  };
}
