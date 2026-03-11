{ config, pkgs, ... }:

{
  programs.ghostty = {
    package = pkgs.ghostty-bin;
    enableZshIntegration = true;
    settings = {
      font-size = 14;
      window-width = 202;
      window-height = 56;
      macos-titlebar-style = "tabs";
      theme = "GitHub Light Default";
    };
  };
}
