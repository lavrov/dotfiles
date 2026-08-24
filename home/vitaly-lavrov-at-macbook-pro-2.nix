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
  services.ollama.enable = true;

  # Headless opencode server (launchd agent), for remote access from
  # OpenCode Desktop, `opencode attach`, or the browser UI.
  #
  # Port pinned (rather than the default random port) so `tailscale serve`
  # below has a stable local target to proxy to.
  programs.opencode.web = {
    enable = true;
    extraArgs = [ "--port" "4096" ];
  };

  # Publish ollama and opencode on the tailnet via `tailscale serve`,
  # instead of binding either service to 0.0.0.0. Runs in the foreground
  # (no --bg), so the mapping's lifetime is tied to this process; KeepAlive
  # keeps it running continuously, restarting it if it ever exits.
  launchd.agents = {
    tailscale-serve-ollama = {
      enable = true;
      config = {
        ProgramArguments = [
          (lib.getExe' pkgs.tailscale "tailscale")
          "serve"
          "--http=11434"
          "11434"
        ];
        RunAtLoad = true;
        KeepAlive = {
          Crashed = true;
          SuccessfulExit = false;
        };
        ProcessType = "Background";
      };
    };

    tailscale-serve-opencode = {
      enable = true;
      config = {
        ProgramArguments = [
          (lib.getExe' pkgs.tailscale "tailscale")
          "serve"
          "--http=4096"
          "4096"
        ];
        RunAtLoad = true;
        KeepAlive = {
          Crashed = true;
          SuccessfulExit = false;
        };
        ProcessType = "Background";
      };
    };
  };
}
