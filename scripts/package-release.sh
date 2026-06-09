#!/usr/bin/env bash
set -euo pipefail

version="${1:?usage: scripts/package-release.sh VERSION}"
root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
stage="$root/dist/ScavengeSurvive-$version"
archive="$root/dist/ScavengeSurvive-$version-linux-x86_64.tar.gz"

rm -rf "$stage" "$archive"
mkdir -p "$stage"

rsync -a \
  --exclude='.git/' \
  --exclude='.github/' \
  --exclude='.sampctl-config/' \
  --exclude='dist/' \
  --exclude='docs/' \
  --exclude='logs/' \
  --exclude='private/' \
  --exclude='server_log.txt' \
  --exclude='scriptfiles/callbackfix.amx' \
  --exclude='scriptfiles/YSI/' \
  --exclude='scriptfiles/carmour/' \
  --exclude='scriptfiles/data/' \
  --exclude='scriptfiles/logs/' \
  --exclude='scriptfiles/maps/session/' \
  "$root/" "$stage/"

required=(
  ss.exe
  samp03svr
  server.cfg
  gamemodes/ScavengeSurvive.amx
  plugins/nolog.so
  plugins/crashdetect.so
  plugins/sscanf.so
  plugins/streamer.so
  plugins/chrono.so
  plugins/pawn-memory.so
  plugins/Whirlpool.so
  plugins/uuid.so
  plugins/fsutil.so
)

for file in "${required[@]}"; do
  test -s "$stage/$file"
done

tar -C "$root/dist" -czf "$archive" "ScavengeSurvive-$version"
sha256sum "$archive" > "$archive.sha256"
