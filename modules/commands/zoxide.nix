{
  ...
}:
{
  home.sessionVariables = {
    _ZO_EXCLUDE_DIRS = "/:/h:/ho:/hom:/home:/home/:/[!h]*:/h[!o]*:/ho[!m]*:/hom[!e]*:/home[!/]*";
  };

  programs.zoxide = {
    enable = true;
    options = [
      "--cmd"
      "cd"
    ];
  };
}
