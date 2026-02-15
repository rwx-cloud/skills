#!/bin/bash
set -euo pipefail

echo "Fetching credentials from Keychain..."
CREDS=$(security find-generic-password -s "Claude Code-credentials" -w)
if [ -z "$CREDS" ]; then
  echo "Error: No credentials found in Keychain. Log in to Claude Code and try again."
  exit 1
fi
ACCESS_TOKEN=$(echo "$CREDS" | jq -r '.claudeAiOauth.accessToken')
EXPIRES_AT=$(echo "$CREDS" | jq -r '.claudeAiOauth.expiresAt')
EXPIRES_DATE=$(date -r $((EXPIRES_AT / 1000)) '+%Y-%m-%d %H:%M:%S %Z')
NOW_MS=$(( $(date +%s) * 1000 ))

if [ "$EXPIRES_AT" -le "$NOW_MS" ]; then
  echo "Error: Claude access token is expired (expired at $EXPIRES_DATE)."
  echo "Please open a Claude session first, then run this script again to get an updated token."
  exit 1
fi

echo "Setting access token in RWX skills vault (expires $EXPIRES_DATE)..."
rwx vaults set-secrets --vault skills "local-claude-access-token=$ACCESS_TOKEN"
echo "Done."
