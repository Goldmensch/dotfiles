{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    settings = {
      homeserver = {
        hostname = "homeserver";
        user = "homie";
      };

      remarkable = {
        hostname = "192.168.178.153";
        user = "root";
      };
    };
  };
}
