{ pkgs, ... }: {
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    plugins = with pkgs.yaziPlugins; {
      gh-clipboard.package = clipboard;
    };

    keymap.mgr.prepend_keymap = [
      {
        on = [ "y" ];
        run = [
          "yank"
          "plugin gh-clipboard -- --action=copy"
        ];
        desc = "Yank selected files (copy)";
      }
      {
        on = [ "x" ];
        run = [
          "yank"
          "plugin gh-clipboard -- --action=copy"
        ];
        desc = "Yank selected files (cut)";
      }
      {
        on = [ "C-p" ];
        run = [ "plugin gh-clipboard -- --action=paste" ];
        desc = "Paste yanked system clipboard files";
      }
    ];
  };

  home.packages = with pkgs; [
    wl-clipboard
  ];

  xdg.desktopEntries.yazi = {
    name = "Yazi File Manager";
    genericName = "Terminal File Manager";
    comment = "Terminal file manager";
    exec = "kitty yazi %f";
    terminal = false;
    type = "Application";
    icon = "yazi";
    categories = [
      "System"
      "FileManager"
      "FileTools"
    ];
    mimeType = [
      "inode/directory"
    ];
  };
}
