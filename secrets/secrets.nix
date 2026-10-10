let
  computhor = "age1yubikey1qv3rpfuvt4edlawp3n0j9v2qg0w82qm4ykhcmhwlgm4352sfvdfg65en37d";
  homeserver = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBfpBFRwMNhkLILhP9J8RfOEvY9tutJ6qZydUXEdgPkE root@homeserver";

  homeserver-rec = [
    computhor
    homeserver
  ];
in
{
  "homeserver/mosquitto-hass-pw.age".publicKeys = homeserver-rec;
  "homeserver/cloudflared-token.age".publicKeys = homeserver-rec;
}
