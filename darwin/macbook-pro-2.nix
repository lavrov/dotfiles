{ ... }:

{
  imports = [ ./common.nix ];

  networking.hostName = "macbook-pro-2";

  users.users."vitaly.lavrov".openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFlCf6iiHJrtIWLplXwJuI+ZRPcrhqR+rWT7+eOcRtRc"
  ];

  services.openssh = {
    enable = true;
    extraConfig = ''
      ListenAddress macbook-pro-2
      PasswordAuthentication no
      PermitRootLogin no
    '';
  };
}
