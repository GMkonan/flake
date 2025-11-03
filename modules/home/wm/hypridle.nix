{...}: {
  services.swayidle = {
    enable = true;
    systemdTarget = "graphical-session.target";
    timeouts = [
      {
        timeout = 30;
        command = "qs -c noctalia-shell ipc call sessionMenu lockAndSuspend";
      }
    ];
    events = [
      {
        event = "before-sleep";
        command = "qs -c noctalia-shell ipc call sessionMenu lockAndSuspend";
      }
    ];
  };
}
