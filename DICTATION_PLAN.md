# Remote Dictation Setup Plan

## Overview
Laptop (NixOS) → Mac Mini (macOS) via Tailscale SSH
Using ggml-large-v3.bin (~2.9GB) for best quality transcription

## Mac Mini Setup

### 1. Install Dependencies
```bash
# Install whisper.cpp via Homebrew
brew install whisper-cpp

# Or if using nix-darwin, add to your config:
# environment.systemPackages = [ pkgs.whisper-cpp ];
```

### 2. Create Directories
```bash
mkdir -p ~/.local/share/whisper
mkdir -p ~/.local/bin
```

### 3. Download Large Model
```bash
cd ~/.local/share/whisper
curl -L -O "https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-large-v3.bin"
# ~2.9GB, takes time
```

### 4. Create Processing Script
Create `~/.local/bin/dictate-process`:

```bash
#!/bin/bash
# Dictation processing script for Mac Mini

WAVFILE="$1"
MODEL="$HOME/.local/share/whisper/ggml-large-v3.bin"

if [ -z "$WAVFILE" ] || [ ! -f "$WAVFILE" ]; then
    echo "Error: No WAV file provided" >&2
    exit 1
fi

if [ ! -f "$MODEL" ]; then
    echo "Error: Model not found" >&2
    exit 1
fi

# Run whisper and output just the text
# Note: macOS compatible (no GNU head -c -1)
whisper-cli -m "$MODEL" -f "$WAVFILE" --no-timestamps --output-txt 2>/dev/null | tr -d '\n'

# Clean up
rm -f "$WAVFILE"
```

Make executable:
```bash
chmod +x ~/.local/bin/dictate-process
```

### 5. Setup Tailscale
```bash
# Install Tailscale
brew install --cask tailscale
# Or from App Store

# Start Tailscale
tailscale up

# Get your hostname
tailscale status
# Note the hostname (e.g., macmini.tailxxxxx.ts.net)
```

### 6. Setup SSH Access
```bash
# Ensure SSH is enabled
sudo systemsetup -setremotelogin on

# Create .ssh directory
mkdir -p ~/.ssh
chmod 700 ~/.ssh
```

## Laptop (NixOS) Setup

### 1. Tailscale (Already Added)
Tailscale service has been added to your configuration.

### 2. SSH Key Setup
Generate SSH key and copy to Mac Mini:
```bash
# Generate key (if not exists)
ssh-keygen -t ed25519 -C "dictation@laptop"

# Copy to Mac Mini (replace with your Mac Mini's Tailscale hostname)
ssh-copy-id macmini.tailxxxxx.ts.net
```

### 3. Test Connection
```bash
# Test SSH
ssh macmini.tailxxxxx.ts.net echo "SSH works!"

# Test dictation process
ssh macmini.tailxxxxx.ts.net dictate-process --help
```

## Dictation Scripts (Laptop Side)

Three scripts will be created:
- `dictate-pt` - Portuguese
- `dictate-en` - English  
- `dictate-auto` - Auto-detect

Each script:
1. Records audio locally with `pw-record`
2. Transfers WAV to Mac Mini via `scp`
3. Runs whisper on Mac Mini via `ssh`
4. Gets text back and types with `wtype`
5. Shows Noctalia notifications

## Keybindings (Niri)

```
Mod+D       → dictate-auto
Mod+Shift+D → dictate-pt
Mod+Ctrl+D  → dictate-en
```

## Workflow

1. Press keybinding
2. 🎙️ "RECORDING" notification appears
3. Speak into microphone
4. Press same keybinding again
5. ⏹️ "STOPPED - Processing on Mac Mini..."
6. File transfers via Tailscale
7. Mac Mini processes with large model
8. Text returns to laptop
9. wtype enters text at cursor
10. ✓ "COMPLETE" notification

## Error Handling

- Network down: "❌ Cannot reach Mac Mini"
- Timeout: "⏱️ Processing timeout"
- No speech: "⚠️ No speech detected"
- Model missing: "❌ Model not found on Mac Mini"

## Next Steps

1. ✅ Tailscale added to laptop config (rebuild needed)
2. Install whisper.cpp on Mac Mini
3. Download large model on Mac Mini
4. Create process script on Mac Mini
5. Setup Tailscale on Mac Mini
6. Generate SSH keys
7. Test SSH connection
8. I'll create the laptop dictation scripts
9. Rebuild and test!

Ready to proceed? Start with steps 2-6 on your Mac Mini!