{pkgs, ...}: {
  services.dunst = {
    enable = true;
    settings = {
      global = {
        # Adjust these settings to your liking
        font = "monospace 10";
        geometry = "x400+0-0"; # Adjust position and size as needed
        ignore = ["summary:Network connection lost"];
      };
      # Example rule to change urgency based on app name
      # urgency_low = {
      #   appname = "discord";
      #   icon = "discord";
      # };
    };
  };
}
