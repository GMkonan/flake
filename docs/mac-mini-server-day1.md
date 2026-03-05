# Mac Mini Server Day-1 Runbook (`mini`)

Goal: turn the `mini` host into a LAN + Tailscale media server using nix-darwin and containers.

## 1) What this setup includes

- Core host via nix-darwin (`mini`): SSH, Tailscale, Docker tooling, CLI utilities.
- Media stack via Docker Compose:
  - Kyoo
  - qBittorrent
  - Sonarr
  - Radarr
  - Bazarr
  - Prowlarr
  - Homepage (service dashboard)
  - Portainer (container dashboard)
  - Glances (host metrics endpoint)
- Access model:
  - All services reachable on LAN.
  - All services reachable through Tailscale.
  - Nothing exposed publicly.

## 2) Disk connection and identification

### Physical connection

- Current media disk: connect your 4TB HDD to the Mac mini using USB/USB-C.
- Future DAS: connect enclosure to Mac mini via USB-C/Thunderbolt.

### How macOS identifies the disk

- Mount path: `/Volumes/<VOLUME_NAME>`
- Device node: `/dev/diskXsY`
- Stable IDs: Volume UUID / Partition UUID

### Commands to verify disk state

```bash
diskutil list
diskutil info "/Volumes/MEDIA"
```

Check that:

- the disk is mounted
- the volume name is stable (`MEDIA` recommended)
- read/write works
- enough free space is available

### How the stack uses the disk

- We bind to mount paths (not raw `/dev/disk*` paths):
  - `/Volumes/MEDIA/media/movies`
  - `/Volumes/MEDIA/media/tv`
  - `/Volumes/MEDIA/media/downloads`
  - `/Volumes/MEDIA/backups/appdata`

## 3) Apply nix-darwin host config

From your repo on the Mac mini:

```bash
nix run nix-darwin -- switch --flake ~/flake#mini
```

Then verify:

```bash
sudo systemsetup -getremotelogin
tailscale status
docker --version
```

Start the Docker engine on macOS (Colima):

```bash
colima start
```

## 4) Prepare server directories

Run the bootstrap script:

```bash
bash services/scripts/bootstrap-storage.sh
```

This creates:

- internal appdata under `/Users/konan/srv/appdata`
- media and backup folders on `/Volumes/MEDIA`

## 5) Configure environment

```bash
cp services/.env.example services/.env
```

Update values in `services/.env`:

- `TZ`
- `PUID` and `PGID` (use your local user IDs)
- `MEDIA_ROOT` if your volume name differs
- all password/API key placeholders
- hostname values (`*.lan`)

## 6) Bring up services

```bash
docker compose --env-file services/.env -f services/compose.yaml up -d
```

Check:

```bash
docker compose --env-file services/.env -f services/compose.yaml ps
```

## 7) Configure local DNS (`*.lan`)

In your router/local DNS, map each hostname to your Mac mini LAN IP:

- `dash.lan`
- `portainer.lan`
- `kyoo.lan`
- `qbit.lan`
- `sonarr.lan`
- `radarr.lan`
- `bazarr.lan`
- `prowlarr.lan`
- `glances.lan`

If your router cannot do this, use temporary hosts-file entries on each client.

## 8) Configure Arr flow (minimal path)

1. Set qBittorrent default save path to `/media/downloads`.
2. In Prowlarr, add indexers and connect Sonarr/Radarr apps.
3. In Sonarr:
   - root folder: `/media/tv`
   - add qBittorrent client
   - enable completed download handling
4. In Radarr:
   - root folder: `/media/movies`
   - add qBittorrent client
   - enable completed download handling
5. In Bazarr:
   - connect Sonarr and Radarr
   - set subtitle languages and automatic subtitle search
6. In Kyoo:
   - point library to `/video` (backed by `${MEDIA_ROOT}` bind)
   - run initial scan

Automation result:

- add title in Sonarr/Radarr
- release found through Prowlarr
- qBittorrent downloads
- Sonarr/Radarr import into final folders
- Bazarr grabs subtitles
- Kyoo serves playback

## 9) Backup (simple v1)

Run manual backup:

```bash
bash services/scripts/backup-appdata.sh
```

Recommended schedule:

- nightly appdata backup to `/Volumes/MEDIA/backups/appdata`
- monthly restore test of one app

Optional launchd schedule (03:00 daily):

```bash
cp services/launchd/com.konan.backup-appdata.plist ~/Library/LaunchAgents/
launchctl unload ~/Library/LaunchAgents/com.konan.backup-appdata.plist 2>/dev/null || true
launchctl load ~/Library/LaunchAgents/com.konan.backup-appdata.plist
```

## 10) Day-1 validation checklist

- [ ] `mini` config applied successfully
- [ ] `/Volumes/MEDIA` mounted and writable
- [ ] Compose stack healthy
- [ ] `*.lan` names resolve on LAN
- [ ] Tailscale access works remotely
- [ ] Sonarr/Radarr import flow works
- [ ] Bazarr subtitle automation works
- [ ] Kyoo playback works
- [ ] backup script produces dated snapshot
