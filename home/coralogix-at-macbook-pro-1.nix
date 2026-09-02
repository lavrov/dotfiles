{ config, lib, pkgs, ... }:

{

  imports = [
    ./common.nix
    ./darwin-common.nix
  ];

  home.username = "coralogix";
  home.homeDirectory = "/Users/coralogix";

  home.sessionPath = [
    "$HOME/.cargo/bin"
  ];

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

  # Import local credentials/secrets into the login shell, if present.
  programs.zsh.profileExtra = ''
    if [ -f "$HOME/.credentials" ]; then
      source "$HOME/.credentials"
    fi
  '';

  # Managed as a launchd service via `darwin-common.nix`, which overrides
  # the package for all macOS configurations.
  services.ollama = {
    enable = true;
    environmentVariables = {
      OLLAMA_CONTEXT_LENGTH = "65536";
    };
  };

  # Forward the local SSH agent (GPG-backed) to macbook-pro-2 so the same
  # key works for git and other SSH operations from that machine.
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings = {
      "macbook-pro-2" = {
        forwardAgent = true;
        user = "vitaly.lavrov";
      };
    };
  };

  home.packages = [

    # utils
    pkgs.htop
    # pkgs.stats
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
    pkgs.nodejs_24
    pkgs.pnpm
    pkgs.bun
    pkgs.go

    # editors & IDEs
    pkgs.jetbrains.idea

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
    # pkgs.pre-commit  # commented out due to Swift build failure on darwin (https://github.com/NixOS/nixpkgs/issues/483584)
    pkgs.awscli2
    pkgs.docker
    pkgs.protofetch
    pkgs.cx-cli

    # AI & LLM
      pkgs.opencode-desktop
      pkgs.jan
    ];
}
