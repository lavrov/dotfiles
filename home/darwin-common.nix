{ config, pkgs, ... }:

{
  # Put the nix-darwin system profile (e.g. `darwin-rebuild`, `tailscale`)
  # on PATH. Managed here rather than via nix-darwin's `programs.zsh`
  # because home-manager owns the zsh configuration.
  home.sessionPath = [ "/run/current-system/sw/bin" ];

  # Use the official macOS build (with MLX support) instead of the nixpkgs
  # `ollama` package whenever `services.ollama` is enabled.
  services.ollama.package = pkgs.callPackage ./ollama-darwin.nix { };

  programs.ghostty = {
    package = pkgs.ghostty-bin;
    enableZshIntegration = true;
    settings = {
      font-size = 14;
      font-thicken = true;
      font-thicken-strength = 40;
      window-width = 202;
      window-height = 56;
      macos-titlebar-style = "tabs";
      theme = "GitHub Light Default";
    };
  };
}
