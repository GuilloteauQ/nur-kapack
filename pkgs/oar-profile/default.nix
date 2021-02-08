{ stdenv, pkgs, fetchFromGitHub }:

pkgs.python37Packages.buildPythonPackage rec {
  name = "oar-profile";
  version = "1.1";

  # src = /home/quentin/oar-profile;
  src = fetchFromGitHub {
    owner = "GuilloteauQ";
    repo = "oar-profile";
    rev = "e1a08a31c6265f6041789e2c6d519570b1b8bf4a";
    sha256 = "09vacjzf3v3ky78pchsmnv2k0zmml62y4lw4yzkfj3hr4lalx9hq";
  };

  propagatedBuildInputs = with pkgs.python37Packages; [
  ];

  doCheck = false;

  postInstall = ''
    cp -r app/ $out
  '';
}

