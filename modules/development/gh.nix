{
  pkgs,
  ...
}:
{
  programs.gh = {
    enable = true;
    extensions = with pkgs; [
      gh-poi
      gh-stack
    ];
    gitCredentialHelper = {
      enable = true;
    };
  };
}
