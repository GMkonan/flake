{pkgs, ...}: {
  # Bootloader.
  # boot.loader.systemd-boot.enable = true;
  # boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.efiSysMountPoint = "/boot";
  boot.loader.grub.enable = true;
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.efiInstallAsRemovable = true;
  boot.loader.grub.extraEntriesBeforeNixOS = false;
  boot.loader.grub.extraEntries = ''
    menuentry "Reboot" {
      reboot
    }
    menuentry "Poweroff" {
      halt
    }
  '';
  # boot.loader.grub.theme = "${pkgs.libsForQt5.breeze-grub}/grub/themes/breeze";
}
