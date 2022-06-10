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
  home.packages = [
    pkgs.htop
    pkgs.jetbrains.idea-community
    pkgs.coursier
    pkgs.slack
  #  pkgs.spotify
  #  pkgs.zoom-us
  #  pkgs.discord
    pkgs.teleport
    pkgs.kubectl
    pkgs.kubectx
    pkgs.jq
    pkgs.nodejs
    pkgs.stern
    pkgs.buf
  ];

  programs.git = {
    enable = true;
    userName = "Vitaly Lavrov";
    userEmail = "vitaly.lavrov@coralogix.com";
    signing = {
      key = "98C3927F192D545A";
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
