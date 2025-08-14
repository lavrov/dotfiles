{ config, pkgs, ... }:

{

  imports = [
    ./common.nix
  ];

  home.username = "coralogix";
  home.homeDirectory = "/Users/coralogix";
}
