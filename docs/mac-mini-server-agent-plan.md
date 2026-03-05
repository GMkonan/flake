# Mac Mini Server Agent Execution Plan

Use this checklist when running an agent directly on the Mac mini.

## Objective

- Convert `mini` into a core server host.
- Deploy LAN + Tailscale media stack with Kyoo + qBittorrent + Arr + dashboards.
- Use current 4TB external disk as media and backup target.

## Phase 1: Host baseline

1. Pull latest repo changes.
2. Apply nix-darwin host:
   - `nix run nix-darwin -- switch --flake ~/flake#mini`
3. Verify:
   - `tailscale status`
   - `docker --version`
   - SSH enabled
4. Start container runtime:
   - `colima start`

## Phase 2: Disk validation

1. Confirm disk is mounted:
   - `diskutil list`
   - `diskutil info "/Volumes/MEDIA"`
2. If needed, rename external volume to `MEDIA`.
3. Validate write access and free space.

## Phase 3: Directory bootstrap

1. Run:
   - `bash services/scripts/bootstrap-storage.sh`
2. Confirm structure exists:
   - `/Users/konan/srv/appdata/...`
   - `/Volumes/MEDIA/media/...`
   - `/Volumes/MEDIA/backups/appdata/...`

## Phase 4: Compose environment

1. Copy env template:
   - `cp services/.env.example services/.env`
2. Fill required values in `.env`:
   - IDs (`PUID`, `PGID`)
   - passwords/API keys
   - LAN hostnames
3. Start stack:
   - `docker compose --env-file services/.env -f services/compose.yaml up -d`
4. Check status:
   - `docker compose --env-file services/.env -f services/compose.yaml ps`

## Phase 5: DNS and routing

1. Add `*.lan` records in router/local DNS to Mac mini LAN IP.
2. Validate all routes:
   - `dash.lan`
   - `portainer.lan`
   - `kyoo.lan`
   - `qbit.lan`
   - `sonarr.lan`
   - `radarr.lan`
   - `bazarr.lan`
   - `prowlarr.lan`
   - `glances.lan`

## Phase 6: Arr workflow setup

1. Configure qBittorrent download paths.
2. Configure Prowlarr indexers and app integrations.
3. Configure Sonarr/Radarr root folders and download client.
4. Configure Bazarr subtitle automation.
5. Trigger Kyoo scan.

## Phase 7: Backup and verification

1. Run backup script:
   - `bash services/scripts/backup-appdata.sh`
2. Confirm backup snapshot on external disk.
3. Run one restore drill for a single app.

## Exit criteria

- All services available on LAN + Tailscale.
- Arr -> qBittorrent -> import -> subtitles -> Kyoo playback confirmed.
- Backup snapshot generated successfully.
