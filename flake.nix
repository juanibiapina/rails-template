# This is a Nix Flake file. It is a declarative way to define a Nix environment
# that can be used to develop and build software in reproducible environments.
{
  inputs = {
    # Use the rolling nixpkgs release maintained by devenv
    nixpkgs.url = "github:cachix/devenv-nixpkgs/rolling";
    # Standard system definitions for cross-platform support
    systems.url = "github:nix-systems/default";
    # devenv provides the development environment shell
    devenv.url = "github:cachix/devenv";
    devenv.inputs.nixpkgs.follows = "nixpkgs";
    # Ruby version support through nixpkgs-ruby
    nixpkgs-ruby.url = "github:bobvanderlinden/nixpkgs-ruby";
    nixpkgs-ruby.inputs = { nixpkgs.follows = "nixpkgs"; };
  };

  # Configure Nix to use the devenv binary cache for faster builds
  nixConfig = {
    extra-trusted-public-keys = "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=";
    extra-substituters = "https://devenv.cachix.org";
  };

  outputs = { self, nixpkgs, devenv, systems, ... } @ inputs:
    let
      forEachSystem = nixpkgs.lib.genAttrs (import systems);
    in
    {
      devShells = forEachSystem
        (system:
          let
            pkgs = nixpkgs.legacyPackages.${system};
          in
          {
            default = devenv.lib.mkShell {
              inherit inputs pkgs;
              modules = [
                {
                  packages = with pkgs; [
                  ];

                  languages.ruby = {
                    enable = true;
                    bundler.enable = true;
                    versionFile = ./.ruby-version;
                  };
                }
              ];
            };
          });
    };
}
