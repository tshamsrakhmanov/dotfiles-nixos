{ config, pkgs, ... }:

{
  home.username = "timur";
  home.homeDirectory = "/home/timur";

  home.packages = [];


  programs.git = {
    enable = true;
    userName = "Timur Shamsrakhmanov";
    userEmail = "tshamsrakhmanov@gmail.com";

    aliases = {
      st = "status -sb";
      lg = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
      cm = "commit -m";
    };

  };

  # Minimal configuration to test
  home.stateVersion = "26.05";
}
