{ config, pkgs, ... }:

{
  imports = [
    ./common.nix
  ];

  home.username = "vitaly";
  home.homeDirectory = "/home/vitaly";

  home.sessionVariables = {
  #  EDITOR = "vi";
  };

  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;
    firefox = {
      enable = true;
      policies = {
        PasswordManagerEnabled = false;
      };
    };
    browserpass = {
      enable = true;
      browsers = [
        "firefox"
      ];
    };
  };

  # Remove SSH_AUTH_SOCK before home-manager will attempt to set it
  home.sessionVariablesExtra = ''
    unset SSH_AUTH_SOCK
  '';
  programs = {
    git = {
      enable = true;
      settings = {
        user = {
          name = "Vitaly Lavrov";
          email = "lavrovvv@gmail.com";
        };
      };
    };
  };

  services.gpg-agent = {
    pinentry = {
      package = pkgs.pinentry-qt;
    };
  };

  services.ollama.acceleration = "rocm";

  home.packages = [
    pkgs.wireguard-tools
    pkgs.jetbrains.idea-community
    pkgs.android-studio
    pkgs.protonmail-desktop
  ];
}
