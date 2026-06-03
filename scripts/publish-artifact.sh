#!/usr/bin/env bash
set -euo pipefail

# Usage:
#   ./scripts/publish-artifact.sh /path/to/file.html slug "Display Title" "Description"
#
# Copies an HTML artifact into docs/artifacts/<slug>/index.html and commits it.
# Push manually after verifying, or uncomment git push below.

FILE="${1:?HTML file path required}"
SLUG="${2:?slug required}"
TITLE="${3:-$SLUG}"
DESC="${4:-Artifact}"

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
DEST="$ROOT/docs/artifacts/$SLUG"
mkdir -p "$DEST"
cp "$FILE" "$DEST/index.html"

python - <<PY
from pathlib import Path
root=Path(r"$ROOT")
idx=root/'docs'/'index.html'
html=idx.read_text(encoding='utf-8')
card=f'''\n      <a class="card" href="./artifacts/$SLUG/">\n        <h2>$TITLE</h2>\n        <p>$DESC</p>\n        <div class="meta"><span class="pill">HTML artifact</span></div>\n      </a>\n'''
if './artifacts/$SLUG/' not in html:
    html=html.replace('    </section>', card+'    </section>', 1)
    idx.write_text(html, encoding='utf-8')
PY

git add docs README.md
git commit -m "Add artifact: $TITLE" || true

echo "Prepared artifact: docs/artifacts/$SLUG/index.html"
echo "After GitHub Pages is enabled, URL will be: https://<username>.github.io/hermes-artifact-hub/artifacts/$SLUG/"
