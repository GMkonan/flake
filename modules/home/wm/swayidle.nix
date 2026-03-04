{
  pkgs,
  lib,
  inputs,
  ...
}: let
  noctaliaPkg = inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default;
  noctaliaExe = lib.getExe noctaliaPkg;

  lockCmd = "${pkgs.bash}/bin/bash -lc '${noctaliaExe} ipc call lockScreen lock'";
  lockAndSuspendCmd = "${pkgs.bash}/bin/bash -lc '${noctaliaExe} ipc call sessionMenu lockAndSuspend'";

  dpmsOff = "${pkgs.niri}/bin/niri msg action power-off-monitors";
  dpmsOn = "${pkgs.niri}/bin/niri msg action power-on-monitors";
in {
  services.swayidle = {
    enable = true;
    systemdTarget = "graphical-session.target";

    timeouts = [
      {
        timeout = 18000; # 15 minutes
        command = lockAndSuspendCmd;
      }
    ];

    events = {
      lock = lockCmd;
      before-sleep = lockCmd;
      after-resume = dpmsOn;
    };
  };

  systemd.user.services.swayidle = {
    Service = {
      PassEnvironment = ["WAYLAND_DISPLAY" "XDG_RUNTIME_DIR" "DBUS_SESSION_BUS_ADDRESS"];
    };
  };
}
