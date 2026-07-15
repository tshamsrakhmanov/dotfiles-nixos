{
  description = "NixOS with Home Manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

   vim-config = {
     url = "github:tshamsrakhmanov/dotfiles-vim";
     flake = false;  # Not a flake
   };
   tmux-config = {
     url = "github:tshamsrakhmanov/dotfiles-tmux";
     flake = false;
   };

  };


  outputs = { self, nixpkgs, home-manager, tmux-config, vim-config, ... }@inputs:
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
          modules = sharedModules ++ [ 
            ./hosts/laptop-old/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                inherit tmux-config vim-config;
              };
              home-manager.users.timur = import ./hosts/laptop-old/home.nix;
            }
          ];
        };
        laptop-new = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = sharedModules ++ [ 
            ./hosts/laptop-new/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                inherit tmux-config vim-config;
              };
              home-manager.users.timur = import ./hosts/laptop-new/home.nix;
            }
          ];
        };
        machine-home = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = sharedModules ++ [ 
            ./hosts/machine-home/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                inherit tmux-config vim-config;
              };
              home-manager.users.timur = import ./hosts/machine-home/home.nix;
            }
          ];
        };
      };
    };
}
