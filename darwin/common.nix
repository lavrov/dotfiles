{ ... }:

{
  # Determinate Nix manages /etc/nix/nix.conf and the nix-daemon itself;
  # let nix-darwin manage everything else.
  # https://docs.determinate.systems/guides/nix-darwin
  nix.enable = false;

  system.stateVersion = 7;

  services.tailscale.enable = true;

  # nix-darwin's services.tailscale module symlinks /etc/resolver/ts.net into
  # the Nix store. Since tailscale 1.98, tailscaled confines its /etc/resolver
  # writes with Go's os.Root, which refuses to traverse a symlink escaping that
  # directory -- so tailscaled fails to apply ANY DNS config with
  # "openat ts.net: path escapes from parent".
  # Let tailscaled manage this file itself.
  environment.etc."resolver/ts.net".enable = false;
}
