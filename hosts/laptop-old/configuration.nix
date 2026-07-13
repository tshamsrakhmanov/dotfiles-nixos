{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];
  
  networking.hostName = "laptop-old";
  system.stateVersion = "26.05";
  
}
