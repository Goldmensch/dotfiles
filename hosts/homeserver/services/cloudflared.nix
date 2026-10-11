{ config, lib, ... }: {
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

  # for agenix -> secrests.nix
  users.users.cloudflared = {
    isSystemUser = true;
    group = "cloudflared";
  };
  users.groups.cloudflared = { };

  systemd.services."cloudflared-tunnel-343aed51-a873-401d-b30b-3d01909ed639".serviceConfig = {
    DynamicUser = lib.mkForce false;
    User = lib.mkForce "cloudflared";
    Group = lib.mkForce "cloudflared";
  };
}
