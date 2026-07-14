{
  description = "NixOS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      sharedModules = [
        ./modules/shared/packages.nix
        ./modules/shared/system_config.nix
        ./modules/shared/flake_enable.nix
      ];

      # Default Home Manager config (applies to all machines)
      defaultHome = ./modules/shared/home.nix;

      # Build home configuration for a specific machine
      mkHome = { hostname, user ? "timur" }:
        let
          machineHome = ./hosts/${hostname}/home.nix;
        in {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.${user} = { config, pkgs, ... }: {
              imports = [
                (import defaultHome)
              ] ++ (if builtins.pathExists machineHome
                    then [ (import machineHome) ]
                    else [ ]);
            };
            extraSpecialArgs = { inherit inputs; };
          };
        };

    in {
      nixosConfigurations = {
        laptop-old = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = sharedModules ++ [
            ./hosts/laptop-old/configuration.nix
            home-manager.nixosModules.home-manager
            (mkHome { hostname = "laptop-old"; })
          ];
        };
        laptop-new = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = sharedModules ++ [
            ./hosts/laptop-new/configuration.nix
            home-manager.nixosModules.home-manager
            (mkHome { hostname = "laptop-new"; })
          ];
        };
        machine-home = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = sharedModules ++ [
            ./hosts/machine-home/configuration.nix
            home-manager.nixosModules.home-manager
            (mkHome { hostname = "machine-home"; })
          ];
        };
      };
    };
}
