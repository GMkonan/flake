{
  services.kanshi = {
    enable = true;
    systemdTarget = "hyprland-session.target";
    settings = [
      {
        profile.name = "undocked";
        profile.outputs = [
          {
            criteria = "eDP-1";
            scale = 1.5;
          }
        ];
      }
      {
        profile.name = "docked";
        profile.outputs = [
          {
            criteria = "eDP-1";
            status = "disable";
          }
          {
            criteria = "Samsung Electric Company LU28R55 HX5W500759";
            # position = "1500,0";
            position = "0,0";
            scale = 2.0;
          }
          # {
          #   criteria = "*";
          #   position = "0,0";
          #   scale = 1.0;
          # }
        ];
      }
    ];
  };
}
