{
  buildPythonPackage,
  fetchFromGitHub,
  lib,
  semantic-version,
  sphinx,
}:

buildPythonPackage rec {
  pname = "releases";
  version = "2.1.1";
  format = "setuptools";

  src = fetchFromGitHub {
    owner = "bitprophet";
    repo = "releases";
    rev = version;
    hash = "sha256-IgEKAUk97R3ZvqvexD/ptT8i0uf48K+DKkk4q3pn3G8=";
  };

  postPatch = ''
    substituteInPlace setup.py --replace "semantic_version<2.7" "semantic_version"
  '';

  propagatedBuildInputs = [
    semantic-version
    sphinx
  ];

  # Test suite doesn't run. See https://github.com/bitprophet/releases/issues/95.
  doCheck = false;

  pythonImportsCheck = [ "releases" ];

  meta = with lib; {
    description = "Sphinx extension for changelog manipulation";
    homepage = "https://github.com/bitprophet/releases";
    license = licenses.bsd2;
    maintainers = with maintainers; [ samuela ];
  };
}
