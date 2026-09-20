{host, ...}: {
  services.paperless = {
    enable = true;
    mediaDir = "${host.homeDirectory}/paperless/data";
    user = host.user;
    consumptionDir = "${host.homeDirectory}/paperless/consume";
    consumptionDirIsPublic = true;
    passwordFile = "${host.homeDirectory}/paperless/password";
    settings.PAPERLESS_OCR_LANGUAGE = "por+eng";
    address = "0.0.0.0";
    port = 28981;
  };

  networking.firewall.allowedTCPPorts = [28981];
}
