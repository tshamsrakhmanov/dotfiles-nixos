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
      
      # Shared home-manager modules (optional)
      #homeModules = [
      #  ./home/modules/common.nix  # Create this if you want shared home config
      #];
    in {
      nixosConfigurations = {
        laptop-old = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit tmux-config vim-config;
          };
          modules = sharedModules ++ [ 
            ./hosts/laptop-old/configuration.nix
            home-manager.nixosModules.home-manager
            {
              # Configure home-manager for this host
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              #home-manager.users.timur = import ./hosts/laptop-old/home.nix;
              #home-manager.users.timur = import ./hosts/laptop-old/home.nix {
              #  inherit tmux-config vim-config;
              #};
              home-manager.users.timur = import ./hosts/laptop-old/home.nix;
              #home-manager.users.timur = { ... } : {
              #  imports = [ ./hosts/laptop-old/home.nix ];
              #  home.file = {
              #    ".tmux.conf".source = "${tmux-config}/.tmux.conf";
              #    ".vimrc".source = "${vim-config}/.vimrc";
              #  };
              #};
              # Or if you want to use the shared modules:
              # home-manager.users.your-username = { ...homeModules, ...import ./hosts/laptop-old/home.nix };
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
              home-manager.users.timur = import ./hosts/machine-home/home.nix;
            }
          ];
        };
      };
    };
}
