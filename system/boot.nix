{ config, pkgs, ... }:
{
  boot = {
  kernelParams = ["nvidia_drm.modeset=1" "quiet" "loglevel=4" "systemd.show_status=false" "rd.udev.log_level=4" "nosgx"];

  # Enable SysRq keys to reboot using REISUB
  kernel.sysctl = {"kernel.sysrq" = 244;};

  # Use Liquorix Kernel
  kernelPackages = pkgs.linuxKernel.packages.linux_lqx;

  # Use systemd initramfs
  initrd.systemd.enable = true;

    loader = {
      timeout = 0;
      #grub = {
      #  enable = true;
      #  device = "nodev";
      #  efiSupport = true;
	    #  efiInstallAsRemovable = true;
      #  enableCryptodisk = true;
      #  extraConfig = ''
      #   if keystatus --shift ; then
      #       set timeout=-1
      #   else
      #       set timeout=0
      #   fi
      #  '';
      #  #extraConfig = ''
      #  #  if sleep --interruptible 0 ; then
      #  #      set timeout=1
      #  #  fi
      #  #'';

      #};
      systemd-boot = {
        enable = true;
        #graceful = true;
      };
    };

    # Enable Plymouth
    #plymouth = {
    #  enable = true;
    #  themePackages = with pkgs; [ nixos-bgrt-plymouth ];
    #  theme = "nixos-bgrt";
    #};
  };
}
