{
  lib,
  config,
  ...
}:
let
  homeDirectory = config.home.homeDirectory;
  length = builtins.stringLength homeDirectory;

  # Every proper prefix of the home directory shorter than the full path
  # (e.g. "/home", "/hom", ... for "/home/alice") is excluded outright.
  properPrefixExcludes = builtins.genList (i: builtins.substring 0 (i + 1) homeDirectory) (
    length - 1
  );

  # zoxide only supports exclude patterns, so the only way to keep just the
  # home directory (and everything below it) is to exclude every directory
  # that diverges from it, character by character, at each position along
  # the path -- falling back to requiring a path separator once the full
  # home directory has been matched.
  divergenceExcludes = builtins.genList (
    i:
    let
      prefixLength = i + 1;
      prefix = builtins.substring 0 prefixLength homeDirectory;
      nextChar = if prefixLength < length then builtins.substring prefixLength 1 homeDirectory else "/";
    in
    "${prefix}[!${nextChar}]*"
  ) length;
in
{
  # Keep everything outside the home directory out of the database.
  home.sessionVariables._ZO_EXCLUDE_DIRS = lib.concatStringsSep ":" (
    properPrefixExcludes ++ divergenceExcludes
  );

  programs.zoxide = {
    enable = true;
    options = [
      "--cmd"
      "cd"
    ];
  };
}
