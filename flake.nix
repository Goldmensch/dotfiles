{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lazyvim = {
      url = "github:pfassina/lazyvim-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/nur";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # homeserver
    rasp = {
      url = "github:nvmd/nixos-raspberrypi/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-anywhere = {
      url = "github:nix-community/nixos-anywhere";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  nixConfig = {
    extra-substituters = [
      "https://nixos-raspberrypi.cachix.org"
      "https://nix-community.cachix.org"
      "https://goldmensch-homeserver.cachix.org"

    ];
    extra-trusted-public-keys = [
      "nixos-raspberrypi.cachix.org-1:4iMO9LXa8BqhU+Rpg6LQKiGa2lsNh/j2oiYLNOQ5sPI="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "goldmensch-homeserver.cachix.org-1:oOfwXSVusF7sqV8Z+8XZzxNdyPphen7xI/XKenO6VpQ="
    ];
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      lazyvim,
      nur,
      agenix,
      nixos-anywhere,
      rasp,
      disko,
      ...
    }@inputs:
    let
      hm-conf = {
        imports = [
          home-manager.nixosModules.home-manager
        ];

        home-manager.extraSpecialArgs = inputs;
      };

      nur-conf = {
        nixpkgs.overlays = [ nur.overlays.default ];
      };

      agenix-conf = {
        imports = [
          agenix.nixosModules.default
        ];
      };

      personal-system =
        { modules }:
        nixpkgs.lib.nixosSystem {
          system = system_64;
          specialArgs = inputs;
          modules = [
            hm-conf
            nur-conf
          ]
          ++ modules;
        };

      system_64 = "x86_64-linux";
    in
    {
      devShells =
        let
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          scriptsDir = ./scripts;
          scripts =
            builtins.mapAttrs
              (
                name: _:
                pkgs.writeShellScriptBin (builtins.replaceStrings [ ".sh" ] [ "" ] name) (
                  builtins.readFile (scriptsDir + "/${name}")
                )
              )
              (
                pkgs.lib.filterAttrs (name: type: type == "regular" && pkgs.lib.hasSuffix ".sh" name) (
                  builtins.readDir scriptsDir
                )
              );

        in
        {
          x86_64-linux.default = pkgs.mkShell {
            name = "dotfiles";
            packages =
              with pkgs;
              [
                git
                agenix.packages.x86_64-linux.default
                age-plugin-yubikey
                nixos-anywhere.packages.x86_64-linux.default
              ]
              ++ builtins.attrValues scripts;
          };
        };

      nixosConfigurations = {
        # main pc
        computhor = personal-system {
          modules = [ ./hosts/personal/computhor ];
        };

        # laptop
        roberto = personal-system {
          modules = [ ./hosts/personal/roberto ];
        };

        # pi4 home server
        homeserver = rasp.lib.nixosSystem {
          specialArgs = inputs // {
            mainPkgs = import nixpkgs {
              system = "aarch64-linux";
              config.allowUnfree = true;
            };
          };
          modules = [
            {
              imports = with rasp.nixosModules; [
                raspberry-pi-4.base
                raspberry-pi-4.bluetooth

                agenix.nixosModules.default
                disko.nixosModules.disko

                ./hosts/homeserver
                hm-conf
              ];
            }
          ];
        };
      };
    };
}
