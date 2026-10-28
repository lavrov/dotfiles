{ config, pkgs, ... }:

let
  # nvm is no longer packaged in nixpkgs or home-manager: pin the upstream
  # release and source it from zsh. The Nix store is read-only, so nvm keeps
  # installing Node versions into its own writable NVM_DIR (~/.nvm).
  nvm = pkgs.fetchFromGitHub {
    owner = "nvm-sh";
    repo = "nvm";
    rev = "v0.40.8";
    hash = "sha256-24FP1brAAyWu+Q0Dk+Y4aXgdCBon9GkBXgFaGXBO7sc=";
  };
in

{
  # Put the nix-darwin system profile (e.g. `darwin-rebuild`, `tailscale`)
  # on PATH. Managed here rather than via nix-darwin's `programs.zsh`
  # because home-manager owns the zsh configuration.
  home.sessionPath = [ "/run/current-system/sw/bin" ];

  # Use the official macOS build (with MLX support) instead of the nixpkgs
  # `ollama` package whenever `services.ollama` is enabled.
  services.ollama.package = pkgs.callPackage ./ollama-darwin.nix { };

  home.packages = [
    (pkgs.callPackage ./claude-desktop-darwin.nix { })
  ];

  programs.home-manager.enable = true;

  # Firefox itself is installed by hand from Mozilla's signed DMG into
  # /Applications: since macOS 27 only Mozilla-signed builds may open
  # ~/Library/Application Support/Firefox, and the nixpkgs build is unsigned.
  # home-manager still applies `programs.firefox.policies` (through macOS
  # defaults) and the browserpass native messaging host.
  programs.firefox.package = null;

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

  programs.zed-editor = {
    enable = true;
  };

  programs.zsh.initContent = ''
    export NVM_DIR="$HOME/.nvm"
    source ${nvm}/nvm.sh
  '';
}
