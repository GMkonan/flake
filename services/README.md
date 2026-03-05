# Services Stack (`mini`)

## Files

- `compose.yaml`: media and dashboard stack
- `.env.example`: environment template
- `Caddyfile`: LAN hostname routing
- `homepage/`: Homepage dashboard config
- `scripts/bootstrap-storage.sh`: creates required directories
- `scripts/backup-appdata.sh`: snapshots appdata to external disk

## Quick start

```bash
cp services/.env.example services/.env
bash services/scripts/bootstrap-storage.sh
colima start
docker compose --env-file services/.env -f services/compose.yaml up -d
```

## Stop

```bash
docker compose --env-file services/.env -f services/compose.yaml down
```

## Backup

```bash
bash services/scripts/backup-appdata.sh
```

## Optional daily schedule (launchd)

```bash
cp services/launchd/com.konan.backup-appdata.plist ~/Library/LaunchAgents/
launchctl load ~/Library/LaunchAgents/com.konan.backup-appdata.plist
```
