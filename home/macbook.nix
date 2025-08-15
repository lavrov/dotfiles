{ config, pkgs, ... }:

{

  imports = [
    ./common.nix
  ];

  home.username = "coralogix";
  home.homeDirectory = "/Users/coralogix";

  programs.git = {
    enable = true;
    userName = "Vitaly Lavrov";
    userEmail = "vitaly.lavrov@coralogix.com";
    signing = {
      key = "E9E1594AB84DF9D0";
      signByDefault = true;
    };
  };

  home.packages = [

    # utils
    pkgs.htop
    pkgs.stats
    pkgs.pritunl-client

    # communication tools
    pkgs.slack
    pkgs.zoom-us

    # entertainment
    pkgs.spotify

    # organizers
    # pkgs.notion

    # programming languages
    pkgs.scala-next
    pkgs.python3
    pkgs.rustup
    pkgs.nodejs_22

    # editors & IDEs
    pkgs.jetbrains.idea-ultimate
    pkgs.jetbrains.webstorm

    # dev tools
    pkgs.teleport
    pkgs.kubectl
    pkgs.kubectx
    pkgs.k9s
    pkgs.jq
    pkgs.stern
    pkgs.protobuf
    pkgs.buf
    pkgs.grpcurl
    pkgs.pre-commit
    pkgs.awscli2

    # AI & LLM
    pkgs.gemini-cli
  ];
}
