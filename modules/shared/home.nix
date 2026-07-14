{ config, pkgs, ... }:

{

  programs.home-manager.enable = true;

  # ---------
  # -- VIM --
  # ---------
  programs.vim = {
    enable = true;
    defaultEditor = true;
  };

  # --------------------
  # -- SHELL ALIASES  --
  # --------------------
  environment.shellAliases = {
    l = "eza -l --color=always --group-directories-first --icons";
    ll = "eza -al --color=always --group-directories-first --icons";
    zz = "exit";
    qq = "ps -eo pid,command | grep";
    update = "sudo nixos-rebuild swtich --flake .";
    ".." = "cd .. && l";
  };


}
