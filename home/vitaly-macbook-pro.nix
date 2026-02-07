{ config, pkgs, ... }:

{

  imports = [
    ./common.nix
  ];

  home.username = "vitaly";
  home.homeDirectory = "/Users/vitaly";

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Vitaly Lavrov";
        email = "lavrovvv@gmail.com";
      };
    };
  };

  services.gpg-agent = {
    pinentry = {
      package = pkgs.pinentry_mac;
    };
  };

  home.packages = [

    # utils
    pkgs.htop
    pkgs.stats
    pkgs.yubikey-manager

    # communication tools
    pkgs.discord

    # entertainment
    pkgs.spotify

    # organizers
    # pkgs.notion

    # programming languages
    pkgs.scala-next
    pkgs.sbt
    pkgs.python3
    pkgs.rustup
    pkgs.nodejs_22

    # editors & IDEs
    pkgs.jetbrains.idea

    # dev tools
    pkgs.kubectl
    pkgs.kubectx
    pkgs.k9s
    pkgs.jq
    pkgs.k3d
    pkgs.docker

    # AI & LLM
    pkgs.gemini-cli
  ];
}
