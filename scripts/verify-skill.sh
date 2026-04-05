#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DIST="$ROOT/dist/openclaw-terse.skill"
CHECKSUM="$DIST.sha256"
TMP_DIR="$(mktemp -d)"
REBUILT="$TMP_DIR/openclaw-terse.skill"

cleanup() {
  rm -rf "$TMP_DIR"
}
trap cleanup EXIT

if [[ ! -f "$DIST" ]]; then
  echo "Missing artifact: $DIST" >&2
  exit 1
fi

bash "$ROOT/scripts/build-skill.sh" "$REBUILT" >/dev/null

if ! cmp -s "$DIST" "$REBUILT"; then
  echo "Artifact drift detected: $DIST does not match source." >&2
  exit 1
fi

if [[ -f "$CHECKSUM" ]]; then
  EXPECTED="$(tr -d '[:space:]' < "$CHECKSUM")"
  ACTUAL="$(sha256sum "$DIST" | awk '{print $1}')"
  if [[ "$EXPECTED" != "$ACTUAL" ]]; then
    echo "Checksum mismatch: $CHECKSUM does not match $DIST." >&2
    exit 1
  fi
fi

echo "Verified $DIST"
