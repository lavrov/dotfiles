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

  # eMudhra intermediate CA compromise (October 2026): nixpkgs cacert still
  # ships the two roots those intermediates chain to, so drop them from the
  # bundle nix-darwin writes to /etc/ssl/certs/ca-certificates.crt.
  # https://emudhra.we-have-a-problem.com/#developers
  # Remove once nixpkgs ships cacert >= 3.131.1.
  security.pki.caCertificateBlacklist = [
    "Comodo AAA Services root"
    "emSign ECC Root CA - G3"
  ];

  # Nix-built OpenSSL (python, git, ...) otherwise falls back to the unpatched
  # bundle in the Determinate Nix default profile.
  environment.variables.SSL_CERT_FILE = "/etc/ssl/certs/ca-certificates.crt";
}
