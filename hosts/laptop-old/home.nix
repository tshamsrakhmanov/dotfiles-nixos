{ config, pkgs, ... }:

{
  home.username = "timur";
  home.homeDirectory = "/home/timur";

  home.packages = [];

  # Minimal configuration to test
  home.stateVersion = "26.05";
}
