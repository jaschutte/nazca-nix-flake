{
  buildPythonPackage,
  pillow,
  pyyaml,
  fastapi,
  httpx,
  ipython,
  matplotlib,
  numpy,
  pyclipper,
  pydantic,
  scipy,
  svgwrite,
  websockets
  # numpy,
  # scipy,
  # pandas233,
  # matplotlib,
  # pillow,
  # ipython,
  # pyyaml,
  # pyclipper,
}:
buildPythonPackage {
  pname = "nazca";
  version = "1.3.0a1";

  # src = fetchTarball {
  #   url = "https://nazca-design.org/dist/nazca-${version}.tar.gz";
  #   sha256 = "sha256-rKEaTJ8JkBgEXRbE07v75VFnKVpAI6WtXqT7PDVHelc=";
  # };

  src = ./nazca-1.3.0a1-py3-none-any.whl;
  format = "wheel";

  # doCheck = false;

  # postPatch =
  #   let
  #     pyproj = ''
  #       [project]
  #       name = "nazca"
  #       version = "0.6.1"
  #       description = "Nazca Design"
  #       readme = "README.md"
  #       requires-python = ">=3.10"
  #       license = "AGPL-3.0-or-later"
  #       authors = [
  #           { name = "Ronald Broeke", email = "R.G.Broeke@gmail.com" },
  #           { name = "Xaveer Leijtens", email = "Xaveer.Leijtens@gmail.com" },
  #       ]
  #       dependencies = [
  #           "numpy>=1.26.0",
  #           "scipy>=1.13.0",
  #           "pandas>=2.2.2",
  #           "matplotlib>=3.8.4",
  #           "Pillow>=9.4.0",
  #           "ipython>=7.20.0",
  #           "PyYAML>=5.1",
  #           "pyclipper>=1.3.0.post5",
  #       ]
  #
  #       [project.urls]
  #       Homepage = "https://nazca-design.org"
  #     '';
  #   in
  #   ''
  #     # The entire pyproject.toml is based around poetry, instead of patching it individually we
  #     # just replace the entire file
  #     echo '${pyproj}' > pyproject.toml
  #   '';
  #
  # postInstall = ''
  #   # Nix doesn't copy over the fonts nor gds files, but nazca depends on them
  #   cp nazca/fonts/*.nft $out/lib/python3.13/site-packages/nazca/fonts
  #   cp nazca/*.gds $out/lib/python3.13/site-packages/nazca
  # '';

  dependencies = [
    pillow
    pyyaml
    fastapi
    httpx
    ipython
    matplotlib
    numpy
    pyclipper
    pydantic
    scipy
    svgwrite
    websockets
  ];

  # pyproject = true;
  # build-system = [
  #   setuptools
  # ];
}
