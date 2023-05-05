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
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Packages that should be installed to the user profile.
  # Commented packages are not yet available on amr64.
  home.packages = [
    pkgs.htop
    pkgs.jetbrains.idea-ultimate
    pkgs.coursier
    pkgs.slack
  #  pkgs.spotify
    pkgs.zoom-us
  #  pkgs.discord
  #  pkgs.vlc
  #  pkgs.etcher
    pkgs.teleport
    pkgs.kubectl
    pkgs.kubectx
    pkgs.jq
    pkgs.python3
    pkgs.stern
    pkgs.buf
    pkgs.scala-cli
    pkgs.httpie
    pkgs.grpcurl
    pkgs.rustup
    pkgs.mysql80
    pkgs.visualvm
    pkgs.jprofiler
    pkgs.unar
    pkgs.syncthing
    pkgs.tree-sitter
    pkgs.emscripten
    pkgs.cmake
  ];

  programs.git = {
    enable = true;
    userName = "Vitaly Lavrov";
    userEmail = "vitaly.lavrov@coralogix.com";
    signing = {
      key = "39CC00C80DB85E36";
      signByDefault = true;
    };
  };

  programs.neovim = {
    enable = true;
  };

  # programs.firefox = {
  #   enable = true;
  # };

  programs.password-store = {
    enable = true;
  };

  programs.gpg = {
    enable = true;
    scdaemonSettings = {
      disable-ccid = true;
    };
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
      gpgconf --launch gpg-agent
    '';
  };

  programs.bat = {
    enable = true;
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;

    oh-my-zsh = {
      enable = true;
      theme = "refined";
      plugins=[
        "git"
      # "tmux"
      # "docker"
      # "python"
       "vi-mode"
      # "systemd"
       "z"
      # "kubectl"
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
    enable = true;
  };
}
