{
# boot.loader.systemd-boot.enable = true;
boot.loader.grub.enable = true;
boot.loader.grub.devices = [ "nodev" ];
boot.loader.grub.efiSupport = true;
boot.loader.efi.canTouchEfiVariables = true;
}
