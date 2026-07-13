{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];
  
  networking.hostName = "machine-new";
  system.stateVersion = "26.05";
  
}
