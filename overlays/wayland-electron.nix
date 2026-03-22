final: prev: {
  slack = prev.slack.overrideAttrs (oldAttrs: {
    nativeBuildInputs = (oldAttrs.nativeBuildInputs or []) ++ [final.makeWrapper];

    postFixup =
      (oldAttrs.postFixup or "")
      + ''
        wrapProgram $out/bin/slack \
          --add-flags "--enable-features=WaylandLinuxDrmSyncobj" \
          --add-flags "--enable-features=UseOzonePlatform" \
          --add-flags "-ozone-platform=wayland" \
          --add-flags "--disable-smooth-scrolling"
      '';
  });

  ticktick = prev.ticktick.overrideAttrs (oldAttrs: {
    nativeBuildInputs = (oldAttrs.nativeBuildInputs or []) ++ [final.makeWrapper];

    postFixup =
      (oldAttrs.postFixup or "")
      + ''
        wrapProgram $out/bin/ticktick \
          --add-flags "--enable-features=WaylandLinuxDrmSyncobj" \
          --add-flags "--enable-features=UseOzonePlatform" \
          --add-flags "-ozone-platform=wayland" \
          --add-flags "--disable-smooth-scrolling"
      '';
  });

  vesktop = prev.vesktop.overrideAttrs (oldAttrs: {
    nativeBuildInputs = (oldAttrs.nativeBuildInputs or []) ++ [final.makeWrapper];

    postFixup =
      (oldAttrs.postFixup or "")
      + ''
        wrapProgram $out/bin/vesktop \
          --add-flags "--enable-features=WaylandLinuxDrmSyncobj"
      '';
  });
}
