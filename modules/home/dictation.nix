{
  config,
  lib,
  pkgs,
  ...
}: let
  # Fetch whisper model
  whisperModel = pkgs.fetchurl {
    url = "https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-small.bin";
    sha256 = "sha256-MuCo7Lg2qdXxHN0/y1hXqjC/y6m/dDX3YCBr9eP40xU=";
  };

  # Base directory for dictation files
  dictationDir = "${config.xdg.dataHome}/dictation";

  # Create the dictation script template
  mkDictateScript = {name, language ? null}: let
    langFlag = lib.optionalString (language != null) "--language ${language}";
  in
    pkgs.writeShellScriptBin name ''
      #!${pkgs.runtimeShell}
      
      # Dictation script with toggle functionality
      PIDFILE="${dictationDir}/${name}.pid"
      WAVFILE="${dictationDir}/${name}.wav"
      MODEL="${dictationDir}/ggml-small.bin"

      # Ensure model exists
      if [ ! -f "$MODEL" ]; then
        mkdir -p "${dictationDir}"
        cp ${whisperModel} "$MODEL"
      fi

      # Toggle: if running, stop it; if not, start it
      if [ -f "$PIDFILE" ] && kill -0 "$(cat "$PIDFILE")" 2>/dev/null; then
        # Stop recording
        PID=$(cat "$PIDFILE")
        
        # Wait a bit for the recording to finish writing
        sleep 0.5
        
        # Kill the recording process
        kill "$PID" 2>/dev/null
        rm -f "$PIDFILE"
        
        # Transcribe and type
        if [ -f "$WAVFILE" ]; then
          TEXT=$(${pkgs.whisper-cpp}/bin/whisper-cli -m "$MODEL" -f "$WAVFILE" --no-timestamps --output-txt 2>/dev/null | head -c -1 | tr -d '\n')
          if [ -n "$TEXT" ]; then
            ${pkgs.wtype}/bin/wtype "$TEXT"
          fi
          rm -f "$WAVFILE"
        fi
      else
        # Start recording
        mkdir -p "${dictationDir}"
        rm -f "$WAVFILE" "$PIDFILE"
        
        # Record audio using pw-record
        ${pkgs.pipewire}/bin/pw-record --rate 16000 --channels 1 "$WAVFILE" &
        echo $! > "$PIDFILE"
      fi
    '';

  # Create the three dictation scripts
  dictate-pt = mkDictateScript {
    name = "dictate-pt";
    language = "pt";
  };

  dictate-en = mkDictateScript {
    name = "dictate-en";
    language = "en";
  };

  dictate-auto = mkDictateScript {
    name = "dictate-auto";
    language = null;
  };
in {
  # Install the dictation scripts and required packages
  home.packages = [
    dictate-pt
    dictate-en
    dictate-auto
    pkgs.whisper-cpp
    pkgs.wtype
    pkgs.pipewire
  ];

  # Create the model file on activation
  home.activation.createWhisperModel = lib.hm.dag.entryAfter ["writeBoundary"] ''
    mkdir -p "${dictationDir}"
    if [ ! -f "${dictationDir}/ggml-small.bin" ]; then
      cp ${whisperModel} "${dictationDir}/ggml-small.bin"
    fi
  '';
}
