{ pkgs
, inputs
, lib
, ...
}: {
  nixpkgs.overlays = [
    # (self: super: {
    #   # yazi = super.yazi.overrideAttrs (old: {
    #   yazi = pkgs.rustPlatform.buildRustPackage {
    #     name = "yazi";
    #     src = super.fetchFromGitHub {
    #       owner = "sxyazi";
    #       repo = "yazi";
    #       rev = "v0.2.1";
    #       sha256 = "sha256-XdN2oP5c2lK+bR3i+Hwd4oOlccMQisbzgevHsZ8YbSQ=";
    #       # sha256 = pkgs.lib.fakeSha256;
    #     };
    #     cargoSha256 = "sha256-SkqcMQGNVNvQ5oMrHS4QrQiFU8PfE0woLizCgN10v+o=";
    #     # cargoSha256 = "";
    #   };
    #   # });
    # })

    # (self: super: {
    #   tmux = super.tmux.overrideAttrs (oldAttrs: rec {
    #     version = "3.0";
    #     src = super.fetchFromGitHub {
    #       owner = "tmux";
    #       repo = "tmux";
    #       rev = version;
    #       sha256 = "sha256-yMoKEiST56gdFi7qBwncHltK7FyI04gXzGIWlGO5TMY=";
    #     };
    #   });
    # })

    # (self: super: {
    #   appimage-run = super.appimage-run.overrideAttrs (old: {
    #     extraPkgs = [ pkgs.libsecret ];
    #   });
    # })
  ];
}
