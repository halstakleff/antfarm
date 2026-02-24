#!/bin/bash
# Title: Schema Drift Scanner
# Purpose: Check frontmatter required fields in all vault notes
# When to Run: Daily via heartbeat
# Outputs: Report of missing required fields

set -euo pipefail

VAULT_PATH="/Users/nit/.openclaw/workspace/ClawOS-Vault"
REPORTS_PATH="$VAULT_PATH/07-Outputs/agent-reports"
TIMESTAMP=$(date +%Y%m%d-%H%M%S)
REPORT="$REPORTS_PATH/schema-drift-$TIMESTAMP.md"

REQUIRED_FIELDS="type:|status:|created:|updated:|retrieval:"

echo "# Schema Drift Report - $TIMESTAMP" > "$REPORT"
echo "" >> "$REPORT"

find "$VAULT_PATH" -name "*.md" -not -path "*/99-Archive/*" | while read -r file; do
  MISSING=""
  for field in type status created updated retrieval; do
    if ! grep -q "^$field:" "$file" 2>/dev/null; then
      MISSING="$MISSING $field"
    fi
  done
  if [ -n "$MISSING" ]; then
    echo "- $(basename "$file"): missing$MISSING" >> "$REPORT"
  fi
done

echo "Scan complete. Report: $REPORT"
