{
  ...
}:
{
  imports = [
    ../services/gpg-agent.nix
  ];

  programs.git = {
    enable = true;
    includes = [
      {
        contents = {
          core = {
            editor = "nvim";
          };
          commit = {
            gpgSign = true;
            verbose = true;
          };
          init = {
            defaultBranch = "main";
          };
          branch = {
            sort = "-committerdate";
          };
          tag = {
            sort = "version:refname";
          };
          diff = {
            algorithm = "histogram";
            colorMoved = "plain";
            mnemonicPrefix = true;
            renames = true;
          };
          push = {
            followTags = true;
            autoSetupRemote = true;
          };
          pull = {
            rebase = true;
          };
          merge = {
            conflictStyle = "zdiff3";
          };
        };
      }
    ];
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      navigate = true;
      line-numbers = true;
      hyperlinks = true;
    };
  };
}
