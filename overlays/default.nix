final: prev: {
  slack = prev.slack.overrideAttrs (oldAttrs: {
    # Ensure makeWrapper is available during the build
    nativeBuildInputs = (oldAttrs.nativeBuildInputs or []) ++ [final.makeWrapper];

    postFixup =
      (oldAttrs.postFixup or "")
      + ''
        echo "Wrapping slack in overlay..."
        wrapProgram $out/bin/slack \
          --add-flags "--enable-features=WaylandLinuxDrmSyncob"
        echo "Slack wrapping complete."
      '';
  });
}
