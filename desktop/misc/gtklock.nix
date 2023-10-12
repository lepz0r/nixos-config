{ config, pkgs, ... }:

{
security.pam.services.gtklock = {
  text = ''
    auth include login
  '';
};
}
