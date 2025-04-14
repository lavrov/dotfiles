{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "vitaly";
  home.homeDirectory = "/Users/vitaly";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Packages that should be installed to the user profile.
  # Commented packages are not yet available on amr64.
  home.packages = [

    # utils
    pkgs.htop
    pkgs.unar
    pkgs.unrar
    pkgs.stats
    # pkgs.etcher
    # pkgs.vlc

    # private cloud
    # pkgs.syncthing


    # communication tools
    pkgs.slack
    pkgs.zoom-us
    pkgs.discord

    # entertainment
    pkgs.spotify

    # organizers
    # pkgs.notion

    # programming languages
    pkgs.scala-next
    pkgs.python3
    pkgs.rustup
    pkgs.unison-ucm

    # editors & IDEs
    pkgs.jetbrains.idea-ultimate
    pkgs.jetbrains.webstorm

    # dev tools
    pkgs.coursier
    pkgs.teleport
    pkgs.kubectl
    pkgs.kubectx
    pkgs.jq
    pkgs.stern
    pkgs.protobuf
    pkgs.buf
    pkgs.httpie
    pkgs.grpcurl
    pkgs.visualvm
    pkgs.jprofiler
    pkgs.tree-sitter
    pkgs.emscripten
    pkgs.cmake
    pkgs.pre-commit
    pkgs.docker-compose
    pkgs.awscli2

    # virtualization
    # pkgs.utm
  ];

  programs.git = {
    enable = true;
    userName = "Vitaly Lavrov";
    userEmail = "vitaly.lavrov@coralogix.com";
    signing = {
      key = "E9E1594AB84DF9D0";
      signByDefault = false;
    };
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    extraLuaConfig = ''
      -- Normal mode -> command mode re-mapping for semicolon (;)
      vim.keymap.set('n', ';', ':', {})
    '';
  };

  programs.zed-editor = {
    enable = true;
  };

  programs.firefox = {
    enable = true;
  };

  programs.password-store = {
    enable = true;
    package = pkgs.pass.withExtensions (exts: [ exts.pass-otp ]);
  };

  programs.gpg = {
    enable = true;
    scdaemonSettings = {
      disable-ccid = true;
    };
  };

  programs.bat = {
    enable = true;
  };

  programs.zsh = {
    enable = true;
    autosuggestion = {
      enable = true;
    };

    enableCompletion = true;

    oh-my-zsh = {
      enable = true;
      theme = "refined";
      plugins=[
       "git"
       "vi-mode"
       "z"
      ];
    };

    initExtra = ''
      export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
      gpgconf --launch gpg-agent
    '';
  };

  programs.direnv.enable = true;

  programs.java.enable = true;

  programs.sbt.enable = true;
  
  programs.go = {
    enable = true;
    goPath = "go";
  };

  programs.vscode = {
    enable = false;
  };

  services.ollama = {
    enable = true;
  };
}
