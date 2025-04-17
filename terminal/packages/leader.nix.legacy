{ pkgs }:

pkgs.stdenv.mkDerivation {
  pname = "leader";
  version = "0.3.2";
  src = pkgs.fetchurl {
    url = "https://github.com/dhamidi/leader/releases/download/v0.3.2/leader.linux.amd64";
    sha256 = "sha256-lwOChHRvDvOm371v5xZUXS//6Dgn4CljioMrIBbWgwY=";
  };

  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/leader
    chmod +x $out/bin/leader
  '';
}
