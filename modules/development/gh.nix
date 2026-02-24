{
  pkgs,
  ...
}:
{
  programs.gh = {
    enable = true;
    extensions = with pkgs; [
      gh-poi
    ];
    gitCredentialHelper = {
      enable = true;
    };
  };
}
