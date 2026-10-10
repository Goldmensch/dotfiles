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
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      lazyvim,
      nur,
      agenix,
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

      agenix-conf = {
        imports = [
          agenix.nixosModules.default
        ];
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
                inputs.agenix.packages.x86_64-linux.default
              ]
              ++ builtins.attrValues scripts;
          };
        };

      nixosConfigurations.computhor = personal-system {
        modules = [ ./hosts/personal/computhor ];
      };

      nixosConfigurations.roberto = personal-system {
        modules = [ ./hosts/personal/roberto ];
      };
    };
}
