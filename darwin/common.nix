{ ... }:

{
  # Determinate Nix manages /etc/nix/nix.conf and the nix-daemon itself;
  # let nix-darwin manage everything else.
  # https://docs.determinate.systems/guides/nix-darwin
  nix.enable = false;

  system.stateVersion = 7;

  services.tailscale.enable = true;
}
