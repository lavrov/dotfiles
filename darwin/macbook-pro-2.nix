{ ... }:

{
  imports = [ ./common.nix ];

  networking.localHostName = "macbook-pro-2";

  users.users."vitaly.lavrov".openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFlCf6iiHJrtIWLplXwJuI+ZRPcrhqR+rWT7+eOcRtRc"
  ];

  services.openssh = {
    enable = true;
    extraConfig = ''
      ListenAddress 100.121.243.86
      PasswordAuthentication no
      PermitRootLogin no
    '';
  };
}
