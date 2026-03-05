#!/usr/bin/env bash
set -euo pipefail

SOURCE_ROOT="/Users/konan/srv/appdata"
TARGET_ROOT="/Volumes/MEDIA/backups/appdata"
STAMP="$(date +%Y-%m-%d_%H-%M-%S)"
SNAPSHOT_DIR="${TARGET_ROOT}/${STAMP}"

if [[ ! -d "/Volumes/MEDIA" ]]; then
  printf 'Missing /Volumes/MEDIA mount. Refusing backup.\n' >&2
  exit 1
fi

if [[ ! -d "${SOURCE_ROOT}" ]]; then
  printf 'Missing source %s\n' "${SOURCE_ROOT}" >&2
  exit 1
fi

mkdir -p "${SNAPSHOT_DIR}"

rsync -a --delete "${SOURCE_ROOT}/" "${SNAPSHOT_DIR}/"

LATEST_LINK="${TARGET_ROOT}/latest"
rm -f "${LATEST_LINK}"
ln -s "${SNAPSHOT_DIR}" "${LATEST_LINK}"

printf 'Backup complete: %s\n' "${SNAPSHOT_DIR}"
