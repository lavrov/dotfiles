{ config, pkgs, ... }:

{
  programs.ghostty = {
    package = pkgs.ghostty-bin;
  };
}
