{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    protofetch = {
      url = "github:coralogix/protofetch";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    opencode = {
      url = "github:anomalyco/opencode/v2";
    };
    cx-cli = {
      url = "github:coralogix/cx-cli";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, protofetch, opencode, cx-cli, nix-darwin, ... }:
    let
      darwinSystem = "aarch64-darwin";
      opencodeOverlays = [
        opencode.overlays.default
        # Upstream nix sets OPENCODE_CHANNEL=prod, which the CLI does not know as a
        # release channel: it registers its service in service-prod.json while the
        # desktop looks in service.json, so the desktop times out waiting for it.
        # The desktop build maps "latest" to its prod identity.
        # Related: https://github.com/anomalyco/opencode/issues/52122 (same
        # OPENCODE_CHANNEL=prod setting also arms the desktop auto-updater).
        (final: prev: {
          opencode = prev.opencode.overrideAttrs (old: {
            env = old.env // { OPENCODE_CHANNEL = "latest"; };
          });
          opencode-desktop = prev.opencode-desktop.override { opencode = final.opencode; };
        })
      ];
      darwinPkgs = import nixpkgs {
        system = darwinSystem;
        config.allowUnfree = true;
        overlays = opencodeOverlays;
      };
      # Adds Coralogix-internal packages on top of the base darwin overlays.
      coralogixDarwinPkgs = import nixpkgs {
        system = darwinSystem;
        config.allowUnfree = true;
        overlays = opencodeOverlays ++ [
          (final: prev: {
            cx-cli = cx-cli.packages.${final.system}.default;
            protofetch = protofetch.packages.${final.system}.default;
          })
        ];
      };
    in {
      homeConfigurations = {
        "vitaly@framework-13" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs { system = "x86_64-linux"; config.allowUnfree = true; };
          modules = [ ./home/framework-13.nix ];
        };
        "coralogix@macbook-pro-1" = home-manager.lib.homeManagerConfiguration {
          pkgs = coralogixDarwinPkgs;
          modules = [ ./home/coralogix-at-macbook-pro-1.nix ];
        };
        "vitaly@macbook-pro-1" = home-manager.lib.homeManagerConfiguration {
          pkgs = darwinPkgs;
          modules = [ ./home/vitaly-at-macbook-pro-1.nix ];
        };
        "vitaly.lavrov" = home-manager.lib.homeManagerConfiguration {
          pkgs = coralogixDarwinPkgs;
          modules = [ ./home/vitaly-lavrov-at-macbook-pro-2.nix ];
        };
      };

      darwinConfigurations = {
        "macbook-pro-1" = nix-darwin.lib.darwinSystem {
          system = darwinSystem;
          modules = [ ./darwin/macbook-pro-1.nix ];
        };
        "macbook-pro-2" = nix-darwin.lib.darwinSystem {
          system = darwinSystem;
          modules = [ ./darwin/macbook-pro-2.nix ];
        };
      };
    };
}
