#!/usr/bin/env bash
set -euo pipefail

# Run this after you provide GitHub auth/token.
# It creates a public GitHub repo and enables GitHub Pages from /docs.

REPO="${1:-hermes-artifact-hub}"
DESC="Mobile-accessible artifact hub for Hermes-generated business decks and reports"

if ! command -v gh >/dev/null 2>&1; then
  echo "gh CLI is not installed. Install it first or use GitHub API/token setup."
  exit 1
fi

if ! gh auth status >/dev/null 2>&1; then
  echo "GitHub CLI is not authenticated. Run: gh auth login"
  exit 1
fi

git init
if [ -z "$(git config user.name || true)" ]; then git config user.name "Colby"; fi
if [ -z "$(git config user.email || true)" ]; then git config user.email "colby@example.com"; fi
git add .
git commit -m "Initial artifact hub" || true

gh repo create "$REPO" --public --description "$DESC" --source . --push
OWNER="$(gh api user --jq '.login')"
gh api -X POST "/repos/$OWNER/$REPO/pages" -f source.branch=main -f source.path=/docs >/dev/null || true

echo "Artifact hub created: https://$OWNER.github.io/$REPO/"
