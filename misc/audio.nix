{ config, pkgs, ... }:

{
# Use PulseAudio
# sound.enable = true;
# hardware.pulseaudio.enable = true;

# Use PipeWire
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;

    # Enable ALSA client support
    alsa.enable = true;
    # Enable PulseAudio client support
    pulse.enable = true;
    # Enable JACK client support
    jack.enable = true;
    alsa.support32Bit = true;
  };
  hardware.pulseaudio.enable = false;
}
