{ config, pkgs, ... }:

{

environment.etc.waybar-config = {
  enable = true;
  target = "xdg/waybar/config";
  text = (builtins.readFile ./waybar-config/config);
};

environment.etc.waybar-style = {
  enable = true;
  target = "xdg/waybar/style.css";
  text = (builtins.readFile ./waybar-config/style.css);
};
}
