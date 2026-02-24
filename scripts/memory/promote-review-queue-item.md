#!/bin/bash
# Title: Promote Review Queue Item
# Purpose: Move approved note from review-queue to active vault section
# When to Run: Weekly review or manual promotion
# Prerequisites: Valid frontmatter, status=approved (or --force)

set -euo pipefail

VAULT_PATH="/Users/nit/.openclaw/workspace/ClawOS-Vault"
REVIEW_QUEUE="$VAULT_PATH/07-Outputs/review-queue"
REPORT_DIR="$VAULT_PATH/07-Outputs/agent-reports"
TIMESTAMP=$(date +%Y%m%d-%H%M%S)
REPORT="$REPORT_DIR/PROMOTION_REPORT.md"

# Parse args
FORCE=false
NOTE_PATH=""

while [[ $# -gt 0 ]]; do
  case $1 in
    --force) FORCE=true; shift ;;
    *) NOTE_PATH="$1"; shift ;;
  esac
done

if [ -z "$NOTE_PATH" ]; then
  echo "Usage: $0 [--force] <note-path>"
  exit 1
fi

# Resolve to absolute path
if [[ ! "$NOTE_PATH" = /* ]]; then
  NOTE_PATH="$REVIEW_QUEUE/$NOTE_PATH"
fi

if [ ! -f "$NOTE_PATH" ]; then
  echo "ERROR: Note not found: $NOTE_PATH"
  exit 1
fi

# Extract frontmatter
TYPE=$(grep "^type:" "$NOTE_PATH" | head -1 | cut -d':' -f2 | tr -d ' '
STATUS=$(grep "^status:" "$NOTE_PATH" | head -1 | cut -d':' -f2 | tr -d ' '

# Validate required frontmatter
if [ -z "$TYPE" ]; then
  echo "ERROR: Missing required frontmatter: type"
  exit 1
fi

if [ -z "$STATUS" ]; then
  echo "ERROR: Missing required frontmatter: status"
  exit 1
fi

# Validate status (approved unless --force)
if [ "$STATUS" != "approved" ] && [ "$FORCE" != true ]; then
  echo "ERROR: Status is '$STATUS', must be 'approved' (use --force to override)"
  exit 1
fi

# Determine destination
DEST_DIR=""
INDEX_FILE=""
case "$TYPE" in
  decision)
    DEST_DIR="$VAULT_PATH/03-Decisions"
    INDEX_FILE="$VAULT_PATH/DECISIONS.md"
    ;;
  lesson)
    DEST_DIR="$VAULT_PATH/06-Lessons"
    INDEX_FILE="$VAULT_PATH/LESSONS.md"
    ;;
  policy)
    DEST_DIR="$VAULT_PATH/01-Operating-System/policies"
    INDEX_FILE="$DEST_DIR/INDEX.md"
    ;;
  project)
    DEST_DIR="$VAULT_PATH/02-Projects/active"
    INDEX_FILE="$VAULT_PATH/PROJECTS.md"
    ;;
  *)
    echo "ERROR: Unknown type: $TYPE"
    exit 1
    ;;
esac

# Create destination
mkdir -p "$DEST_DIR"

# Extract filename
FILENAME=$(basename "$NOTE_PATH")

# Move file
DEST_PATH="$DEST_DIR/$FILENAME"
mv "$NOTE_PATH" "$DEST_PATH"

# Update frontmatter
sed -i '' "s/^status:.*/status: promoted/" "$DEST_PATH"
sed -i '' "s/^retrieval:.*/retrieval: include/" "$DEST_PATH"
sed -i '' "s/^updated:.*/updated: $(date +%Y-%m-%d)/" "$DEST_PATH"

# Update index
if [ -f "$INDEX_FILE" ]; then
  echo "- [[${FILENAME%.md}]]" >> "$INDEX_FILE"
fi

# Write report
echo "## Promotion Report - $TIMESTAMP" >> "$REPORT"
echo "- Note: $FILENAME" >> "$REPORT"
echo "- Source: $NOTE_PATH" >> "$REPORT"
echo "- Destination: $DEST_PATH" >> "$REPORT"
echo "- Type: $TYPE" >> "$REPORT"
echo "- Status: promoted (was: $STATUS)" >> "$REPORT"
echo "" >> "$REPORT"

echo "PROMOTED: $FILENAME → $DEST_DIR"
echo "Report: $REPORT"
