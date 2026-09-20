{
  services.netbird.ui.enable = false;
  services.netbird.clients.wt0 = {
    name = "netbird";
    interface = "wt0";
    hardened = false;
    port = 51821;
    ui.enable = false;
    openFirewall = true;
    openInternalFirewall = true;
    autoStart = false;
  };
}
