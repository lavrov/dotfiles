{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    protofetch = {
      url = "github:lavrov/protofetch";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, protofetch, ... }: {
    homeConfigurations = {
      "vitaly@framework-13" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { system = "x86_64-linux"; config.allowUnfree = true; };
        modules = [ ./home/framework-13.nix ];
      };
      "coralogix@macbook-pro" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { system = "aarch64-darwin"; config.allowUnfree = true; };
        modules = [ ./home/coralogix-macbook-pro.nix ];
        extraSpecialArgs = {
          inherit protofetch;
        };
      };
      "vitaly@macbook-pro" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { system = "aarch64-darwin"; config.allowUnfree = true; };
        modules = [ ./home/vitaly-macbook-pro.nix ];
      };
    };
  };
}
