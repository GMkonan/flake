{
  config,
  lib,
  pkgs,
  ...
}: let
  # Mac Mini configuration
  macMiniHost = "gmkonans-mac-mini"; # Tailscale hostname
  macMiniUser = "GMkonan"; # Your username on Mac Mini

  # Dictation directory on laptop (for temp files)
  dictationDir = "${config.xdg.dataHome}/dictation";

  # Remote paths on Mac Mini
  remoteWavPath = "/tmp/dictation-input.wav";
  remoteProcessCmd = "~/.local/bin/dictate-process";

  # Create the dictation script template
  mkDictateScript = {
    name,
    langName,
  }:
    pkgs.writeShellScriptBin name ''
      #!${pkgs.runtimeShell}

      # Remote dictation script - records locally, processes on Mac Mini
      PIDFILE="${dictationDir}/${name}.pid"
      WAVFILE="${dictationDir}/${name}.wav"
      MACMINI="${macMiniHost}"
      MACMINI_USER="${macMiniUser}"

      # Notification helper
      notify() {
        local title="$1"
        local message="$2"
        noctalia-shell ipc call toast send "{\"title\": \"$title\", \"message\": \"$message\"}" 2>/dev/null || true
      }

      # Ensure dictation directory exists
      mkdir -p "${dictationDir}"

      # Toggle: if running, stop it; if not, start it
      if [ -f "$PIDFILE" ] && kill -0 "$(cat "$PIDFILE")" 2>/dev/null; then
        # Stop recording
        PID=$(cat "$PIDFILE")

        # Notify stopping
        notify "⏹️ STOPPED" "Sending to Mac Mini for processing..."

        # Wait a bit for the recording to finish writing
        sleep 0.5

        # Kill the recording process
        kill "$PID" 2>/dev/null
        rm -f "$PIDFILE"

        # Check if Mac Mini is reachable
        if ! ssh -o ConnectTimeout=5 "$MACMINI" echo "connected" >/dev/null 2>&1; then
          notify "❌ ERROR" "Cannot reach Mac Mini ($MACMINI)"
          rm -f "$WAVFILE"
          exit 1
        fi

        # Transfer audio to Mac Mini
        if ! scp "$WAVFILE" "$MACMINI:${remoteWavPath}" 2>/dev/null; then
          notify "❌ ERROR" "Failed to transfer audio to Mac Mini"
          rm -f "$WAVFILE"
          exit 1
        fi

        # Process on Mac Mini and get text back
        notify "⏳ PROCESSING" "Mac Mini is transcribing..."
        TEXT=$(ssh "$MACMINI" "${remoteProcessCmd} ${remoteWavPath}" 2>/dev/null)

        if [ -n "$TEXT" ]; then
          # Use clipboard + paste for Electron apps (Discord/Slack) compatibility
          echo -n "$TEXT" | ${pkgs.wl-clipboard}/bin/wl-copy
          sleep 0.2
          ${pkgs.wtype}/bin/wtype -M ctrl v -m ctrl
          notify "✓ COMPLETE" "Text entered successfully"
        else
          notify "⚠️ EMPTY" "No speech was detected"
        fi

        # Cleanup local file
        rm -f "$WAVFILE"

      else
        # Start recording
        rm -f "$WAVFILE" "$PIDFILE"

        # Check if Mac Mini is reachable before starting
        if ! ssh -o ConnectTimeout=5 "$MACMINI" echo "connected" >/dev/null 2>&1; then
          notify "❌ ERROR" "Cannot reach Mac Mini ($MACMINI)"
          exit 1
        fi

        # Notify starting
        notify "🎙️ RECORDING" "Dictation active - speak now (${langName})"

        # Record audio using pw-record
        ${pkgs.pipewire}/bin/pw-record --rate 16000 --channels 1 "$WAVFILE" &
        echo $! > "$PIDFILE"
      fi
    '';

  # Create the three dictation scripts
  dictate-pt = mkDictateScript {
    name = "dictate-pt";
    langName = "PT";
  };

  dictate-en = mkDictateScript {
    name = "dictate-en";
    langName = "EN";
  };

  dictate-auto = mkDictateScript {
    name = "dictate-auto";
    langName = "Auto";
  };
in {
  # Install the dictation scripts and required packages
  home.packages = [
    dictate-pt
    dictate-en
    dictate-auto
    pkgs.wtype
    pkgs.wl-clipboard
    pkgs.pipewire
  ];
}
