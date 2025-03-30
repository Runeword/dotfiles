# Function to create a symlink to a file outside the Nix store
{
  pkgs,
  workspacePath ? /home/charles/term,
}:

path:
let
  fileName = builtins.baseNameOf path;
in
"${
  pkgs.runCommandLocal "out-of-store-symlink-${fileName}"
    {
      allowSubstitutes = false;
      preferLocalBuild = true;
    }
    ''
      mkdir -p $out
      ln -s ${toString workspacePath}/${toString path} $out/${fileName}
    ''
}/${fileName}"

