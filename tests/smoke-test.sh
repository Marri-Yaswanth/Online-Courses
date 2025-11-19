#!/bin/bash
# Simple smoke test for the static site
set -euo pipefail
URL=${1:-http://localhost:8000/courses.html}
STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$URL")
if [ "$STATUS" -ne 200 ]; then
  echo "Smoke test failed: expected 200 but got $STATUS"
  exit 2
fi
# check that main title exists
BODY=$(curl -s "$URL")
if ! echo "$BODY" | grep -q "StudyVerse"; then
  echo "Smoke test failed: page does not contain expected title"
  exit 3
fi

echo "Smoke test passed: $URL returned 200 and contains expected text"
