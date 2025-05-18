{
  pkgs,
  extraPackages,
  extraConfigs,
}:
pkgs.runCommand "extra-wrapper"
  {
    nativeBuildInputs = [ pkgs.makeWrapper ];
  }
  ''
    mkdir -p $out/bin

    # Create symlinks for extra configs
    ${pkgs.lib.concatStringsSep "\n" (pkgs.lib.mapAttrsToList (name: path: 
      "${pkgs.lib.mkLink path ".config/${name}"}"
    ) extraConfigs)}

    # Create a wrapper that adds extra packages to PATH
    makeWrapper ${pkgs.bash}/bin/bash $out/bin/extra-wrapper \
      --prefix PATH : ${pkgs.lib.makeBinPath extraPackages}
  '' 