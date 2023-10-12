{ config, pkgs, ... }:

{
  imports = [
      ./programs/zsh.nix
      ./programs/starship.nix
      
      # Enable neovim
      ./programs/neovim.nix
    ];


  # Enable programs
  programs = {
    htop.enable = true;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # environment.systemPackages = with pkgs; [
  # ];
}
