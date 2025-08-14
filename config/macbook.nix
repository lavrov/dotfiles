{ config, pkgs, ... }:

{

  home.username = "coralogix";
  home.homeDirectory = "/Users/coralogix";

  home.stateVersion = "25.11";

  services.ollama = {
    enable = true;
  };
}
