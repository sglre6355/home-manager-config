{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    veracrypt
  ];

  home.shellAliases = {
    veracrypt = "veracrypt -t";
  };
}
