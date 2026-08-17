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
      url = "github:anomalyco/opencode";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    codebase-memory-mcp = {
      url = "github:DeusData/codebase-memory-mcp";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    cx-cli = {
      url = "github:coralogix/cx-cli";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, protofetch, opencode, codebase-memory-mcp, cx-cli, ... }: {
    homeConfigurations = {
      "vitaly@framework-13" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { system = "x86_64-linux"; config.allowUnfree = true; };
        modules = [ ./home/framework-13.nix ];
      };
      "coralogix" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "aarch64-darwin";
          config.allowUnfree = true;
          overlays = [
            opencode.overlays.default
            (final: prev: {
              codebase-memory-mcp = codebase-memory-mcp.packages.${final.system}.default;
              cx-cli = cx-cli.packages.${final.system}.default;
              protofetch = protofetch.packages.${final.system}.default;
            })
          ];
        };
        modules = [ ./home/coralogix-macbook-pro.nix ];
      };
      "vitaly" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "aarch64-darwin";
          config.allowUnfree = true;
          overlays = [ opencode.overlays.default ];
        };
        modules = [ ./home/vitaly-macbook-pro.nix ];
      };
    };
  };
}
