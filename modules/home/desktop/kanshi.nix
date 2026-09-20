{
  services.kanshi = {
    enable = true;
    systemdTarget = "graphical-session.target";
    settings = [
      {
        profile.name = "docked";
        profile.outputs = [
          {
            criteria = "eDP-1";
            status = "disable";
          }
          {
            criteria = "Samsung Electric Company LU28R55 HX5W500759";
            position = "0,0";
            scale = 2.0;
          }
        ];
      }
      {
        profile.name = "undocked";
        profile.outputs = [
          {
            criteria = "eDP-1";
            status = "enable";
            scale = 1.3;
          }
        ];
      }
    ];
  };
}
