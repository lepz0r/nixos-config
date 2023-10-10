{ config, pkgs, ... }:

{
programs = {
    starship = {
      enable = true;
      #settings = [ (builtins.fromTOML (builtins.readFile ./starship/config.toml)) ];
    };
};
}
