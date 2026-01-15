{ config, pkgs, protofetch, ... }:

{

  imports = [
    ./common.nix
  ];

  home.username = "coralogix";
  home.homeDirectory = "/Users/coralogix";

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Vitaly Lavrov";
        email = "vitaly.lavrov@coralogix.com";
      };
    };
    signing = {
      key = "EBB3F3ECCC29C9F5";
      signByDefault = true;
    };
  };

  home.packages = [

    # utils
    pkgs.htop
    pkgs.stats
    # pkgs.pritunl-client

    # communication tools
    pkgs.slack
    pkgs.zoom-us

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
    pkgs.pnpm

    # editors & IDEs
    pkgs.jetbrains.idea-ultimate

    # dev tools
    pkgs.teleport
    pkgs.kubectl
    pkgs.kubectx
    pkgs.argo-rollouts
    pkgs.k9s
    pkgs.jq
    pkgs.stern
    pkgs.protobuf
    pkgs.buf
    pkgs.grpcurl
    pkgs.pre-commit
    pkgs.awscli2
    pkgs.docker
    protofetch.packages.${pkgs.system}.default

    # AI & LLM
    pkgs.goose-cli
  ];
}
