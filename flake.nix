{
  description = "deck - Tool for building slides from markdown";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    treefmt-nix.url = "github:numtide/treefmt-nix";
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-darwin" ];

      imports = [
        inputs.treefmt-nix.flakeModule
      ];

      perSystem = { config, pkgs, ... }: {
        packages.default = pkgs.buildGoModule rec {
          pname = "deck";
          version = "1.24.4";

          src = pkgs.fetchFromGitHub {
            owner = "k1LoW";
            repo = "deck";
            rev = "v${version}";
            sha256 = "sha256-lTBanbAb0klUrqhvhyht4u+K006YgiXya2ovg/ElrL4=";
          };

          vendorHash = "sha256-06OqWG5Mn7avaTDL5YJgcKjQ/JWTAB2Cqg/DMINGydo=";
          doCheck = false;
        };

        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            go
          ];
          packages = [ config.packages.default ];
        };

        treefmt.programs.nixpkgs-fmt.enable = true;
      };
    };
}
