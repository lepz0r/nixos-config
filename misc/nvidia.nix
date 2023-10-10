{ config, pkgs, lib, ... }:

{
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  hardware.nvidia = {
    modesetting.enable = true;
    nvidiaSettings = true;
    powerManagement.enable = true;
  };

  services.xserver.videoDrivers = ["nvidia"];
  environment.systemPackages = with pkgs; [nvidia-vaapi-driver];

}
