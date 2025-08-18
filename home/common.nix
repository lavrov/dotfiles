{ config, pkgs, ... }:

{

  home.stateVersion = "25.11";

  # essentials
  programs = {

    home-manager.enable = true;

    zsh = {
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

      shellAliases = {
        switch = "cd ~/workspace/github.com/lavrov/dotfiles && home-manager switch --flake .";
        flake-update = "cd ~/workspace/github.com/lavrov/dotfiles && nix flake update";
      };
    };

    git = {
      enable = true;
    };

    password-store = {
      enable = true;
      package = pkgs.pass.withExtensions (exts: [ exts.pass-otp ]);
    };

    gpg = {
      enable = true;
      scdaemonSettings = {
        disable-ccid = true;
      };
    };

    bat = {
      enable = true;
    };

    direnv = {
      enable = true;
    };
  };

  services = {
    gpg-agent = {
      enable = true;
      enableSshSupport = true;
    };
    ollama = {
      enable = true;
    };
  };


  # editors
  programs = {

    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      plugins = with pkgs.vimPlugins; [
      ];
      extraLuaConfig = ''
        -- Normal mode -> command mode re-mapping for semicolon (;)
        vim.keymap.set('n', ';', ':', {})
      '';
    };

    zed-editor = {
      enable = true;
    };
  };

  # desktop
  programs = {
    firefox = {
      enable = true;
    };
  };
}
