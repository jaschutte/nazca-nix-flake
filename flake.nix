{
  description = "Usable developer shell & package build for Nazca";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs =
    {
      self,
      nixpkgs,
    }:
    let
      pkgs = import nixpkgs {
        system = "x86_64-linux";
      };

      nazca = pkgs.callPackage ./derivation.nix {
        inherit (pkgs.python313Packages)
          setuptools
          buildPythonPackage
          numpy
          scipy
          pandas
          matplotlib
          pillow
          ipython
          pyyaml
          pyclipper
          ;
      };

      python = pkgs.python313.override {
        self = python;
        packageOverrides = final: prev: {
          inherit nazca;
        };
      };
    in
    {
      packages.x86_64-linux.default = nazca;

      devShells.x86_64-linux.default = pkgs.mkShell {
        packages = [
          (python.withPackages (pypkgs: [
            pypkgs.nazca
          ]))
          pkgs.klayout
        ];
      };
    };
}
