{ config, pkgs, ... }:

{
programs = {
  zsh = {
    enable = true;
    histSize = 10000;
    autosuggestions = {
      enable = true;
      strategy = ["history" "completion"];
    };
    syntaxHighlighting.enable = true;
  };
};
}
