{ pkgs, ... }:
let
  unityhub = pkgs.unityhub.overrideAttrs (old: rec {
    version = "3.22.5";

    src = pkgs.fetchurl {
      url = "https://hub.unity3d.com/linux/repos/deb/pool/main/u/unity/unityhub_amd64/UnityHubSetup-${version}-amd64.deb";
      hash = "sha256-+/cR+388r/EBXFB8HrX3HRx5YGUilC8h5xYxRlUyHUM=";
    };

    installPhase =
      builtins.replaceStrings
        [
          "mv opt/ usr/share/ $out"
          "$out/opt/unityhub"
          "/opt/unityhub/unityhub"
        ]
        [
          "mv usr/lib/ usr/share/ $out"
          "$out/lib/unityhub"
          "/usr/bin/unityhub"
        ]
        old.installPhase;
  });
in
{
  home.packages = [
    unityhub
    pkgs.proxychains
    pkgs.firejail
  ];
}
