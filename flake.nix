{
  description = "NixOS configuration with flakes";
  inputs.nixos-hardware.url = github:NixOS/nixos-hardware/master;

  outputs = { self, nixpkgs, nixos-hardware }: {
    nixosConfigurations.dell-xps-9310 = nixpkgs.lib.nixosSystem {
      modules = [
        nixos-hardware.nixosModules.dell-xps-13-9310
      ];
    };
  };
}

