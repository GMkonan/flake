final: prev: {
  slack = prev.slack.overrideAttrs (oldAttrs: {
    # Ensure makeWrapper is available during the build
    nativeBuildInputs = (oldAttrs.nativeBuildInputs or []) ++ [final.makeWrapper];

    postFixup =
      (oldAttrs.postFixup or "")
      + ''
        echo "Wrapping slack in overlay..."
        wrapProgram $out/bin/slack \
          --add-flags "--enable-features=WaylandLinuxDrmSyncobj" \
          --add-flags "--enable-features=UseOzonePlatform" \
          --add-flags "-ozone-platform=wayland" \
          --add-flags "--disable-smooth-scrolling"

        echo "Slack wrapping complete."
      '';
  });

  vesktop = prev.vesktop.overrideAttrs (oldAttrs: {
    # Ensure makeWrapper is available during the build
    nativeBuildInputs = (oldAttrs.nativeBuildInputs or []) ++ [final.makeWrapper];

    postFixup =
      (oldAttrs.postFixup or "")
      + ''
        echo "Wrapping vesktop in overlay..."
        wrapProgram $out/bin/vesktop \
          --add-flags "--enable-features=WaylandLinuxDrmSyncobj"

        echo "Vesktop wrapping complete."
      '';
  });
}
