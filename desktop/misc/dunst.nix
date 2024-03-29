{ config, pkgs, ... }:

{
environment.etc.dunst = {
  enable = true;
  target = "xdg/dunst/dunstrc";
  text = ''
  [global]
      frame_color = "#BD93F9"
      font=JetBrainsMono Nerd Font 10

  [urgency_low]
      # IMPORTANT: colors have to be defined in quotation marks.
      # Otherwise the "#" and following would be interpreted as a comment.
      background = "#282a36"
      foreground = "#6272a4"
      timeout = 10
      # Icon for notifications with low urgency, uncomment to enable
      #new_icon = /path/to/icon
  
  [urgency_normal]
      background = "#282a36"
      foreground = "#bd93f9"
      timeout = 10
      # Icon for notifications with normal urgency, uncomment to enable
      #new_icon = /path/to/icon
  
  [urgency_critical]
      background = "#ff5555"
      foreground = "#f8f8f2"
      frame_color = "#ff5555"
      timeout = 0
      # Icon for notifications with critical urgency, uncomment to enable
      #new_icon = /path/to/icon
         '';
};

}
