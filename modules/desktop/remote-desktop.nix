{
  lib,
  pkgs,
  ...
}:
{
  home.packages =
    with pkgs;
    [
      remmina
    ]
    ++ lib.optionals stdenv.isLinux [
      wayvnc
    ];
}
