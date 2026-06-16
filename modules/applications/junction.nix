{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    junction
  ];

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = [ "re.sonny.Junction.desktop" ];
      "x-scheme-handler/http" = [ "re.sonny.Junction.desktop" ];
      "x-scheme-handler/https" = [ "re.sonny.Junction.desktop" ];
    };
  };
}
