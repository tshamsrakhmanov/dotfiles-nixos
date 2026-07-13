{ config, pkgs, ... }:

{
  users.users.timur = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      tree
    ];
  };
}
