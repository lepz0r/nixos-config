
{ config, pkgs, ... }:
{

 # Define a user account. Don't forget to set a password with ‘passwd’.
  users = { 
    defaultUserShell = pkgs.zsh;
    users.cincinmasukmangkok = {
      isNormalUser = true;
      # Enable sudo for this user
      extraGroups = [ "wheel" ]; 
      uid = 1000;
    };
  };
  security.pam.enableFscrypt = true;

  systemd.user.extraConfig = ''
    DefaultEnvironment="PATH=/run/current-system/sw/bin"
  '';
}
