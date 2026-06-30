{ config, pkgs, ... }:

{

  home.stateVersion = "26.05";

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
        oc = "opencode-cli";
	k = "kubectl";
      };
    };

    git = {
      enable = true;
      ignores = [
        ".opencode"
      ];
    };

    ghostty = {
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
      environmentVariables = {
        OLLAMA_CONTEXT_LENGTH = "65536";
      };
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
      initLua = ''
        -- Normal mode -> command mode re-mapping for semicolon (;)
        vim.keymap.set('n', ';', ':', {})
      '';
    };

    zed-editor = {
      enable = false;
    };
  };

  # desktop
  programs = {
    firefox = {
      enable = true;
      policies = {
        DisablePasswordManager = true;
      };
    };
    browserpass = {
      enable = true;
      browsers = ["firefox"];
    };
  };

  # desktop
  programs = {
    opencode = {
      enable = true;
      package = pkgs.symlinkJoin {
        name = "opencode-cli";
        paths = [ pkgs.opencode ]; 
        postBuild = ''
          ln -s $out/bin/opencode $out/bin/opencode-cli
        '';
      };
    };
  };
}
