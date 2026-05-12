{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    remmina
    wayvnc
  ];
}
