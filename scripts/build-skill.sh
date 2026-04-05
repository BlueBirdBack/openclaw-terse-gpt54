#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SRC_DIR="$ROOT/skills/openclaw-terse"
DEFAULT_OUT="$ROOT/dist/openclaw-terse.skill"
OUT="${1:-$DEFAULT_OUT}"
OUT_DIR="$(dirname "$OUT")"
STAGE="$(mktemp -d)"

cleanup() {
  rm -rf "$STAGE"
}
trap cleanup EXIT

mkdir -p "$OUT_DIR"
mkdir -p "$STAGE/openclaw-terse"
cp -R "$SRC_DIR/." "$STAGE/openclaw-terse/"

while IFS= read -r -d '' path; do
  touch -t 202001010000 "$path"
done < <(find "$STAGE" -print0)

rm -f "$OUT"
(
  cd "$STAGE"
  LC_ALL=C find openclaw-terse -type f | sort | zip -X -q "$OUT" -@
)

sha256sum "$OUT" | awk '{print $1}' > "$OUT.sha256"
echo "Built $OUT"
