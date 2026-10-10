{ pkgs, config, ... }: {
  programs.firefox = {
    enable = true;
    configPath = "${config.xdg.configHome}/mozilla/firefox";

    profiles = {
      nick = {
        extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
          bitwarden
        ];
        search = {
          default = "ddg";
          force = true;
        };
        settings = {
          # for cosmic theming
          "widget.gtk.libadwaita-colors.enabled" = false;
          # disable firefox pw manager
          "signon.rememberSignons" = false;

          # enforece darkmode
          "ui.systemUsesDarkTheme" = 1;

          # preset shortcuts (top sites)
          "browser.newtabpage.pinned" = ''
            [
              {
                "url": "https://www.youtube.com/",
                "label": "YouTube"
              },
              {
                "url": "https://www.icloud.com/",
                "label": "icloud"
              },
              {
                "url": "https://github.com/",
                "label": "github"
              },
              {
                "url": "https://search.nixos.org/packages",
                "label": "Nix search"
              },
              {
                "url": "http://localhost:631/admin",
                "label": "Cups"
              },
              {
                "url": "http://192.168.178.168:8123",
                "label": "HomeAssistant"
              },
              {
                "url": "https://cloud.nickhensel.de",
                "label": "NextCloud"
              }
            ]
          '';

          # fuck off sponsors // well doens't really work... fuck capitalism!!!
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
          "browser.newtabpage.activity-stream.showSponsored" = false;
          "browser.urlbar.suggest.topsites" = false;
          "services.sync.prefs.sync.browser.urlbar.suggest.topsites" = false;
        };
      };
    };
  };
}
