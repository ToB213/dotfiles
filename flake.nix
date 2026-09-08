{
  description = "Cross-platform Darwin and WSL development environment";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs =
    inputs@{
      nix-darwin,
      nixpkgs,
      home-manager,
      ...
    }:
    let
      darwinSystem = "aarch64-darwin";
      linuxSystem = "x86_64-linux";
      forAllSystems = nixpkgs.lib.genAttrs [
        darwinSystem
        linuxSystem
      ];
    in
    {
      formatter = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        pkgs.writeShellApplication {
          name = "dotfiles-fmt";
          runtimeInputs = [
            pkgs.findutils
            pkgs.nixfmt
          ];
          text = ''
            find . -name '*.nix' -not -path './.git/*' -print0 | xargs -0 nixfmt
          '';
        }
      );

      darwinConfigurations."tob" = nix-darwin.lib.darwinSystem {
        modules = [
          ./hosts/tob
          home-manager.darwinModules.home-manager
        ];
      };

      homeConfigurations."tob-wsl" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = linuxSystem;
          config.allowUnfree = true;
        };
        modules = [ ./hosts/tob-wsl/home.nix ];
      };
    };
}
