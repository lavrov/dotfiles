{ config, pkgs, ... }:

{

  # essentials
  programs = {

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
    };

    git = {
      enable = true;
      userName = "Vitaly Lavrov";
      userEmail = "lavrovvv@gmail.com";
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
  };

  services = {
    ollama = {
      enable = true;
    };
  };


  home.packages = [];
}
