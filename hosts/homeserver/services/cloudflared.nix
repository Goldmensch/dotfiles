{ config, ... }: {
  services.cloudflared = {
    enable = true;
    tunnels = {
      "343aed51-a873-401d-b30b-3d01909ed639" = {
        credentialsFile = config.age.secrets.cloudflared-token.path;
        ingress = {
          "hm.goldmensch.dev" = "http://192.168.178.168:8123";
        };
        default = "http_status:404";
      };
    };
  };
}
