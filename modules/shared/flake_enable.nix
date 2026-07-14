{ config, pkgs, ... }:

{
  # Enable flakes globally for all machines
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
