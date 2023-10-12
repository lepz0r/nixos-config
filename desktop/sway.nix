{ config, pkgs, lib, ... }:

let
  # bash script to let dbus know about important env variables and
  # propagate them to relevent services run at the end of sway config
  # see
  # https://github.com/emersion/xdg-desktop-portal-wlr/wiki/"It-doesn't-work"-Troubleshooting-Checklist
  # note: this is pretty much the same as  /etc/sway/config.d/nixos.conf but also restarts  
  # some user services to make sure they have the correct environment variables
  dbus-sway-environment = pkgs.writeTextFile {
    name = "dbus-sway-environment";
    destination = "/bin/dbus-sway-environment";
    executable = true;

    text = ''
  dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
  systemctl --user stop pipewire wireplumber xdg-desktop-portal xdg-desktop-portal-wlr
  systemctl --user start pipewire wireplumber xdg-desktop-portal xdg-desktop-portal-wlr
      '';
  };

  # currently, there is some friction between sway and gtk:
  # https://github.com/swaywm/sway/wiki/GTK-3-settings-on-Wayland
  # the suggested way to set gtk settings is with gsettings
  # for gsettings to work, we need to tell it where the schemas are
  # using the XDG_DATA_DIR environment variable
  # run at the end of sway config
  configure-gtk = pkgs.writeTextFile {
      name = "configure-gtk";
      destination = "/bin/configure-gtk";
      executable = true;
      text = let
        schema = pkgs.gsettings-desktop-schemas;
        datadir = "${schema}/share/gsettings-schemas/${schema.name}";
      in ''
        export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS
        gnome_schema=org.gnome.desktop.interface
        gsettings set $gnome_schema gtk-theme 'Dracula'
        '';
  };
in

{

imports = [
            ./misc/gtklock.nix
            ./misc/foot.nix
            ./misc/waybar-sway.nix
            ./misc/rofi-config.nix
          ];

environment.systemPackages = with pkgs; [
alacritty 
rofi-wayland
dracula-theme
dracula-icon-theme
gnome3.adwaita-icon-theme
grim
dunst
killall
];

programs = {
  sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraOptions = [
      "--unsupported-gpu"
    ];
  };

  waybar.enable = true;
};

fonts.fonts = with pkgs; [
  (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
];

environment.etc.sway = {
  enable = true;
  target = "sway/config.d/zz-extra-sway-config.conf";
  text = ''
         # Set Dracula color scheme

         # class                 border  bground text    indicator child_border
         client.focused          #BD93F9 #BD93F9 #F8F8F2 #BD93F9   #BD93F9
         client.focused_inactive #44475A #44475A #F8F8F2 #44475A   #44475A
         client.unfocused        #282A36 #282A36 #BFBFBF #282A36   #282A36
         client.urgent           #44475A #FF5555 #F8F8F2 #FF5555   #FF5555
         client.placeholder      #282A36 #282A36 #F8F8F2 #282A36   #282A36
         
         client.background       #F8F8F2

         # Set border size
         default_border pixel 4
         
         # Set gaps size
         gaps inner 4
         ''
         + "output * bg " + pkgs.nixos-artwork.wallpapers.dracula.gnomeFilePath + " fill" +
         ''

         # Only enable gaps on a workspace when there is at least one container
         smart_gaps on

         # Activate smart borders (only when there are effectively no gaps)
         smart_borders no_gaps

         exec_always sh -c "until killall swaybar; do sleep 0.5; done"

         exec waybar

         set $menu /etc/run-rofi.sh -show drun
         bindsym --no-warn $mod+d exec $menu
         '';
};
}
