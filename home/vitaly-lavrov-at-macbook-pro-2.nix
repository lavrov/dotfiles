{ config, lib, pkgs, ... }:

{

  imports = [
    ./common.nix
    ./darwin-common.nix
  ];

  home.username = "vitaly.lavrov";
  home.homeDirectory = "/Users/vitaly.lavrov";

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
    # Listen on all interfaces instead of just localhost.
    host = "0.0.0.0";
  };

  # Headless opencode server (launchd agent), for remote access from
  # OpenCode Desktop, `opencode attach`, or the browser UI.
  programs.opencode.web.enable = true;
}
