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
        };
      }
    ];
  };
}
