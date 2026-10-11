let
  base = ../../secrets/homeserver;
  r-mode = "0400";
in
{
  age.secrets = {
    "mosquitto-hass-pw.yaml" = {
      file = base + "/mosquitto-hass-pw.yaml.age";
      owner = "zigbee2mqtt";
      mode = r-mode;
    };

    cloudflared-token = {
      file = base + "/cloudflared-token.age";
      owner = "cloudflared";
      mode = r-mode;
    };
  };
}
