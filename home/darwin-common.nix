{ config, pkgs, ... }:

{
  programs.ghostty = {
    package = pkgs.ghostty-bin;
    enableZshIntegration = true;
    settings = {
      font-size = 14;
      macos-titlebar-style = "tabs";
      theme = "GitHub Light Default";
    };
  };
}
