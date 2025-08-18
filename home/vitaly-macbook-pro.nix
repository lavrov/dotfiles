{ config, pkgs, ... }:

{

  imports = [
    ./common.nix
  ];

  home.username = "vitaly";
  home.homeDirectory = "/Users/vitaly";

  programs.git = {
    enable = true;
    userName = "Vitaly Lavrov";
    userEmail = "lavrovvv@gmail.com";
  };

  home.packages = [

    # utils
    pkgs.htop
    pkgs.stats

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
    pkgs.jetbrains.idea-community

    # dev tools
    pkgs.kubectl
    pkgs.kubectx
    pkgs.k9s
    pkgs.jq

    # AI & LLM
    pkgs.gemini-cli
  ];
}
