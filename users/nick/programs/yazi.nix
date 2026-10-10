{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
  };

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
