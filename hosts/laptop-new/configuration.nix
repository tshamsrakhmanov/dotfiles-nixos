{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];
  
  networking.hostName = "laptop-new";
  system.stateVersion = "26.05";
  
}
