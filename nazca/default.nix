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
}:
buildPythonPackage {
  pname = "nazca";
  version = "1.3.0a1";

  src = ./nazca-1.3.0a1-py3-none-any.whl;
  format = "wheel";

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
}
