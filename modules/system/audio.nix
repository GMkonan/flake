{
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  # wpctl status
  # wpctl set-default
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    jack.enable = true;
    pulse.enable = true;
  };
}
