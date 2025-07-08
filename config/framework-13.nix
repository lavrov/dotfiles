{ config, pkgs, ... }:

{
  imports = [
    ./common.nix
  ];

  home.username = "vitaly";
  home.homeDirectory = "/home/vitaly";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  home.sessionVariables = {
  #  EDITOR = "vi";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Remove SSH_AUTH_SOCK before home-manager will attempt to set it
  home.sessionVariablesExtra = ''
    unset SSH_AUTH_SOCK
  '';

  services.gpg-agent = {
    pinentry = {
      package = pkgs.pinentry-qt;
    };
  };

  services.ollama = {
    enable = true;
    acceleration = "rocm";
  };

  home.packages = [
    pkgs.wireguard-tools
    pkgs.jetbrains.idea-community
    pkgs.android-studio
  ];
}
