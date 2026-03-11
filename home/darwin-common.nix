{ config, pkgs, ... }:

{
  programs.ghostty = {
    package = pkgs.ghostty-bin;
    enableZshIntegration = true;
    settings = {
      font-size = 16;
      font-family = "JetBrainsMono";
      macos-titlebar-style = "tabs";
      theme = "GitHub Light Default";
    };
  };
}
