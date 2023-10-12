{ config, pkgs, lib, fetchurl, ... }:

let 
  theme = builtins.fetchurl {
    url = "https://raw.githubusercontent.com/dracula/rofi/459eee340059684bf429a5eb51f8e1cc4998eb74/theme/config2.rasi";
  };
in

{
  environment.etc.rofi-config = {
    enable = true;
    target = "rofi.rasi";
    text = (builtins.readFile theme );
  };

  environment.etc.rofi-runner = {
    enable = true;
    mode = "0755";
    target = "run-rofi.sh";
    text = ''
    #!/usr/bin/env bash
    config="~/.config/rofi/config.rasi"
    if [[ -f $file ]]; then
    	rofi $@ &
    else
    	rofi -config /etc/rofi.rasi $@ &
    fi
    '';
  };
}
