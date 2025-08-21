{}: {
  services.kanshi = {
    enable = true;
    systemdTarget = "graphical-session.target";
    settings = [
      {
        output.criteria = "eDP-1";
        output.scale = 1;
      }
      {
        profile.name = "undocked";
        profile.outputs = [
          {
            criteria = "eDP-1";
            status = "enable";
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
            position = "0,900";
            scale = 2;
          }
          {
            criteria = "*";
            position = "0,0";
            scale = 1.4;
          }
        ];
      }
    ];
  };
}
