{ config, pkgs, ... }:

{
  programs = {

    git = {
      enable = true;
      userName = "Vitaly Lavrov";
      userEmail = "lavrovvv@gmail.com";
    };

    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      plugins = with pkgs.vimPlugins; [
        unison
      ];
      coc = {
        enable = true;
        settings = {
          languageserver = {
              unison = {
                filetypes = ["unison"];
                host = "127.0.0.1";
                port = 5757;
                settings = {};
              };
  	      };
        };
      };
      extraLuaConfig = ''
        -- Normal mode -> command mode re-mapping for semicolon (;)
        vim.keymap.set('n', ';', ':', {})
      '';
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
}
