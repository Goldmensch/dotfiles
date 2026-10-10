{
  programs.git = {
    enable = true;
    settings = {
      core.autocrlf = "input";
      core.eol = "lf";
      pull.rebase = true;
      safe.directory = "/etc/nixos";
      push.autoSetupRemote = true;

      user.name = "Goldmensch";
      user.email = "pm@goldmensch.dev";
    };

    signing = {
      key = "0x8512EE59";
      signByDefault = true;
    };
  };
}
