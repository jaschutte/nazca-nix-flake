{
  buildPythonPackage,
  nazca,
}:
buildPythonPackage {
  pname = "semiconlab";
  version = "0.1.1a2";

  src = ./semiconlab-0.1.1a2-py3-none-any.whl;
  format = "wheel";

  dependencies = [
    nazca
  ];
}
