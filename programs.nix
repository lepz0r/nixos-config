{ config, pkgs, ... }:

{
  imports = [
      ./programs/zsh.nix
      ./programs/starship.nix
    ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  #environment.systemPackages = with pkgs; [
  #];
}
