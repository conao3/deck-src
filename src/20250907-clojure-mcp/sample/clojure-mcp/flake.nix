{
  description = "Clojure project";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    treefmt-nix.url = "github:numtide/treefmt-nix";
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-darwin"
      ];

      imports = [
        inputs.treefmt-nix.flakeModule
      ];

      perSystem =
        { pkgs, config, ... }:
        {
          packages.default = pkgs.hello;

          devShells.default = pkgs.mkShell {
            packages = with pkgs; [
              graalvmPackages.graalvm-ce
              (clojure.override { jdk = graalvmPackages.graalvm-ce; })
              clojure-lsp
              nodejs_latest
            ];
          };

          treefmt = {
            programs.nixfmt.enable = true;
            programs.cljfmt.enable = true;
          };
        };
    };
}
