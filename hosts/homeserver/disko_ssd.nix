{ lib, ... }:

let
  firmwarePartition = lib.recursiveUpdate {
    priority = 1;

    attributes = [
      0
    ];

    size = "1024M";
    content = {
      type = "filesystem";
      format = "vfat";
      mountOptions = [
        "noatime"
        "noauto"
        "x-systemd.automount"
        "x-systemd.idle-timeout=1min"
      ];
    };
  };

  espPartition = lib.recursiveUpdate {

    type = "EF00";
    attributes = [
      2
    ];

    size = "1024M";
    content = {
      type = "filesystem";
      format = "vfat";
      mountOptions = [
        "noatime"
        "noauto"
        "x-systemd.automount"
        "x-systemd.idle-timeout=1min"
        "umask=0077"
      ];
    };
  };

in {

  # https://nixos.wiki/wiki/Btrfs#Scrubbing
  services.btrfs.autoScrub = {
    enable = true;
    interval = "monthly";
    fileSystems = [ "/" ];
  };

  fileSystems = {
    "/var/log".neededForBoot = true;
  };

  disko.devices.disk.main = {
    type = "disk";
    device = "/dev/sda";

    content = {
      type = "gpt";
      partitions = {

        FIRMWARE = firmwarePartition {
          label = "FIRMWARE";
          content.mountpoint = "/boot/firmware";
        };

        ESP = espPartition {
          label = "ESP";
          content.mountpoint = "/boot";
        };

        system = {
          type = "8305";  # Linux ARM64 root (/)

          size = "100%";
          content = {
            type = "btrfs";
            extraArgs = [
              "-f"
            ];
            subvolumes = {
              "/rootfs" = {
                mountpoint = "/";
                mountOptions = [ "noatime" ];
              };
              "/nix" = {
                mountpoint = "/nix";
                mountOptions = [ "noatime" ];
              };
              "/home" = {
                mountpoint = "/home";
                mountOptions = [ "noatime" ];
              };
              "/log" = {
                mountpoint = "/var/log";
                mountOptions = [ "noatime" ];
              };
              "/swap" = {
                mountpoint = "/.swapvol";
                swap."swapfile" = {
                  size = "5G";
                  priority = 3; # (higher number -> higher priority)
                  # to be used after zswap (set zramSwap.priority > this priority),
                  # but before "hibernation" swap
                  # https://github.com/nix-community/disko/issues/651
                };
              };
            };
          };
        };  # system

        swap = {
          type = "8200";  # Linux swap

          size = "5G";  # RAM + 1GB
          content = {
            type = "swap";
            resumeDevice = true;  # "hibernation" swap
            # zram's swap will be used first, and this one only
            # used when the system is under pressure enough that zram and
            # "regular" swap above didn't work
            # https://github.com/systemd/systemd/issues/16708#issuecomment-1632592375
            # (set zramSwap.priority > btrfs' .swapvol priority > this priority)
            priority = 2;
          };
        };

      };
    };

  };  # disko.devices.disk.main
}
