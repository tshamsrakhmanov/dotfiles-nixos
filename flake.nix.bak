{
  description = "NixOS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
outputs = { self, nixpkgs, ... }@inputs:
    let
      sharedModules = [
        ./modules/shared/users.nix
        ./modules/shared/packages.nix
        ./modules/shared/system_config.nix
        ./modules/shared/flake_enable.nix
      ];
    in {
      nixosConfigurations = {
        laptop-old = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = sharedModules ++ [ ./hosts/laptop-old/configuration.nix ];
        };
        laptop-new = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = sharedModules ++ [ ./hosts/laptop-new/configuration.nix ];
        };
        machine-home = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = sharedModules ++ [ ./hosts/machine-home/configuration.nix ];
        };
      };
    };
}
