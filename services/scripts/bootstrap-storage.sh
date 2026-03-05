#!/usr/bin/env bash
set -euo pipefail

APPDATA_ROOT="/Users/konan/srv/appdata"
CACHE_ROOT="/Users/konan/srv/cache/kyoo"
MEDIA_ROOT="/Volumes/MEDIA/media"
BACKUP_ROOT="/Volumes/MEDIA/backups/appdata"

if [[ ! -d "/Volumes/MEDIA" ]]; then
  printf 'Missing /Volumes/MEDIA mount. Mount or rename your media disk to MEDIA first.\n' >&2
  exit 1
fi

mkdir -p \
  "${APPDATA_ROOT}/caddy/data" \
  "${APPDATA_ROOT}/caddy/config" \
  "${APPDATA_ROOT}/homepage/images" \
  "${APPDATA_ROOT}/portainer" \
  "${APPDATA_ROOT}/qbittorrent" \
  "${APPDATA_ROOT}/prowlarr" \
  "${APPDATA_ROOT}/sonarr" \
  "${APPDATA_ROOT}/radarr" \
  "${APPDATA_ROOT}/bazarr" \
  "${CACHE_ROOT}" \
  "${MEDIA_ROOT}/downloads" \
  "${MEDIA_ROOT}/movies" \
  "${MEDIA_ROOT}/tv" \
  "${BACKUP_ROOT}"

printf 'Storage bootstrap complete.\n'
