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
      callPyPackage = pkgs.lib.callPackageWith pkgs.python313Packages;

      pkgs = import nixpkgs {
        system = "x86_64-linux";
      };

      semiconlab = callPyPackage ./semiconlab.nix {
        inherit nazca;
      };

      pandas233 = callPyPackage ./pandas233.nix {
        inherit (pkgs)
          fetchFromGitHub
          glibc
          pkg-config
          runtimeShell
          ;
        # Since cython 3.1 isn't packaged in this version of nixpkgs, we just use 3.2
        # This seems to compile fine
        cython_3_1 = pkgs.python313Packages.cython_3_2;
        adv_cmds = pkgs.darwin.adv_cmds;
      };

      nazca = callPyPackage ./nazca.nix {
        # Pandas 3.0.4 has an incompatible API with Nazca
        inherit pandas233;
      };

      python = pkgs.python313.override {
        self = python;
        packageOverrides = final: prev: {
          inherit nazca semiconlab;
        };
      };
    in
    {
      packages.x86_64-linux = {
        inherit nazca semiconlab;
        default = nazca;
      };

      devShells.x86_64-linux.default = pkgs.mkShell {
        packages = [
          (python.withPackages (pypkgs: [
            pypkgs.nazca
            pypkgs.semiconlab
          ]))
          pkgs.klayout
        ];
      };
    };
}
