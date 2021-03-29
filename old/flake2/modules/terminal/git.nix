{ pkgs, ... }:
{
  programs.git = {
    enable = true;
    package = pkgs.unstable.git;
    extraConfig = {
      init.defaultBranch = "main";
      url."git@github.com:" = {
        pushinsteadOf = "https://github.com/";
      };
    };
    
    userEmail = "16954508+xdHampus@users.noreply.github.com";
    userName = "Hampus";
  };
}
