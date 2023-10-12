# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # Define custom mounts & volume encryption options here here.
      ./custom-mount.nix
      # Define user accounts here. Don't forget to set a password with ‘passwd’.
      ./users.nix

      # Desktop Environment/Window Manager config
      # Use sway
      ./desktop/sway.nix

      # Define installed programs here
      ./programs.nix

      # Use NVIDIA proprietary driver, don't forget to set nixpkgs.config.allowUnfree = true;
      #./misc/nvidia.nix
      # Increase password hashing strength
      ./system/pam.nix
      # Boot configurations are here
      ./system/boot.nix
      # Audio configurations
      ./misc/audio.nix


    ];

  networking.hostName = "nix0s"; # Define your hostname.

  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Asia/Jakarta";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # environment.systemPackages = with pkgs; [
  #   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #   wget
  # ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = true;

  # Enable polkit for wayland
  security.polkit.enable = true;

  # Enable AppArmor
  security.apparmor.enable = true;

  # Set environment variables
  environment.sessionVariables = rec {
    #WLR_NO_HARDWARE_CURSORS="1";
    #WLR_RENDERER_NO_ATOMIC="1";
    MOZ_ENABLE_WAYLAND="1";
    #WLR_RENDERER="vulkan";
    #QT_QPA_PLATFORM="wayland-egl";
    NIXOS_OZONE_WL = "1";
    #GTK_THEME="adw-gtk3";
    #SDL_VIDEODRIVER="wayland";
    # Not officially in the specification
    XDG_BIN_HOME    = "$HOME/.local/bin";
    PATH = [ 
      "${XDG_BIN_HOME}"
    ];
    NIX_IMPURE_BASH = "bash";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}

