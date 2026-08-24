{ ... }:

{
  imports = [ ./common.nix ];

  networking.localHostName = "macbook-pro-2";

  services.openssh = {
    enable = true;
    extraConfig = ''
      ListenAddress 100.87.5.74
      PasswordAuthentication no
      PermitRootLogin no
    '';
  };
}
