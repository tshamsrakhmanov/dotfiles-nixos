{
  description = "NixOS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      sharedModules = [
        ./modules/shared/users.nix
        ./modules/shared/packages.nix
        ./modules/shared/defaults.nix
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
