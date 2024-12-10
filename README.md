Codify everything!
==================

1. [Install](https://zero-to-nix.com/start/install/) nix package manager
2. Make sure `username@hostname` matches home-manager configuration name (e.g. vitaly@framework-13)
3. Run initial switch from repository root directory
    
       nix run home-manager/master -- switch --flake .

    This will install `home-manager` command on the host.
