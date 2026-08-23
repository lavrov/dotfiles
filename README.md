Codify everything!
=================

1. [Install](https://zero-to-nix.com/start/install/) nix package manager
2. Make sure `username@hostname` matches home-manager configuration name
3. Run initial switch from repository root directory

        nix run home-manager/master -- switch --flake .

    This will install `home-manager` command on the host.

4. After initial setup, use:

        home-manager switch --flake .

Available configurations:
- `vitaly@framework-13` (x86_64-linux)
- `coralogix@macbook-pro-1` (aarch64-darwin)
- `vitaly@macbook-pro-1` (aarch64-darwin)
- `vitaly@macbook-pro-2` (aarch64-darwin)

## macOS: disable sleep (including on lid close)

Not managed by Nix (requires root). Run manually on each machine where needed:

    sudo pmset disablesleep 1

To revert:

    sudo pmset disablesleep 0
