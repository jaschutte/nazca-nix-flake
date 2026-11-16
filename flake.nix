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
      callPyPackage = pkgs.lib.callPackageWith python.pkgs;

      pkgs = import nixpkgs {
        system = "x86_64-linux";
      };

      semiconlab = callPyPackage ./semiconlab.nix { };
      nazca = callPyPackage ./nazca.nix { };

      python = pkgs.python313.override {
        self = python;
        packageOverrides = final: prev: {
          inherit nazca semiconlab;

          pillow = prev.pillow.overridePythonAttrs (old: rec {
            version = "12.3.0";
            src = prev.fetchPypi {
              pname = "pillow";
              inherit version;
              sha256 = "sha256-O4GCp2ZoXqoAJjfii07I1rGIGaDHH1eb8NuqWDApfM4=";
            };
          });
          websockets = prev.websockets.overridePythonAttrs (old: rec {
            version = "16.1.1";
            src = prev.fetchPypi {
              pname = "websockets";
              inherit version;
              sha256 = "sha256-2yNO2pZdzOFd+Wu5cJ9YfNh9TVKq8OgOLzTsBMdnDFc=";
            };

            # Fails to find a file used for tests, ignoring it for now
            doCheck = false;
          });
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
