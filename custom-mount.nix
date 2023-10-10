{ config, lib, pkgs, modulesPath, ... }:

{
  # Set ESP Partition mounting location
  boot.loader.efi.efiSysMountPoint = "/boot";

  #fileSystems = {
  #  # Set btrfs mount options for root volume, don't forget to remove "discard=async" if your volume don't support TRIM
  #  "/" = 
  #  {
  #      neededForBoot = true;
  #      options = [ "compress=zstd" "noatime" "subvol=root" "discard=async" ];
  #  };
  #};

  # Set root subvolume encryption options
  #boot.initrd = {
  #  luks.devices = {
  #    nix0s = {
  #      device = "/dev/disk/by-uuid/68d7ed20-7dd9-42eb-bd80-3634631c8dae";
  #      # Enable this if the root volume is on LVM
  #      preLVM = true;
  #      # Enable this if to enable TRIM for encrypted volume
  #      allowDiscards = true;
  #    };
  #  };
  #};

  # Create crypttab in /etc to decrypt on stage 2
  #environment.etc.crypttab = {
  # enable = true;
  # mode = "0600";
  # text = ''
  # another-encrypted-volume UUID=aa082618-dc41-41cf-b105-851697333b8d /etc/secrets/key.bin
  # '';
  #};
}
