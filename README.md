# Hermes Artifact Hub

A mobile-accessible public GitHub Pages hub for HTML decks, reports, and business artifacts generated from Telegram/Hermes.

## Purpose

Instead of sending local PC paths like `C:/Users/...`, future artifacts should be published here and shared as web links that open directly from Telegram/mobile.

## Publishing flow

1. Copy generated artifact into `docs/artifacts/<slug>/index.html`.
2. Update `docs/index.html` with the latest link.
3. Commit and push.
4. Share the GitHub Pages URL in Telegram.

Expected URL shape after setup:

```text
https://<github-username>.github.io/hermes-artifact-hub/artifacts/<slug>/
```
