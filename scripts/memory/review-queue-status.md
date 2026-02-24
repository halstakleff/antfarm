#!/bin/bash
# Title: Review Queue Status
# Purpose: Report pending/approved/rejected items in review queue
# When to Run: Weekly review or on-demand

set -euo pipefail

VAULT_PATH="/Users/nit/.openclaw/workspace/ClawOS-Vault"
REVIEW_QUEUE="$VAULT_PATH/07-Outputs/review-queue"
REPORT_DIR="$VAULT_PATH/07-Outputs/agent-reports"
TIMESTAMP=$(date +%Y%m%d-%H%M%S)
REPORT="$REPORT_DIR/REVIEW_QUEUE_STATUS.md"

echo "# Review Queue Status - $TIMESTAMP" > "$REPORT"
echo "" >> "$REPORT"

# Count by status
declare -A COUNTS
COUNTS[pending]=0
COUNTS[approved]=0
COUNTS[rejected]=0
COUNTS[promoted]=0

# List pending
echo "## Pending" >> "$REPORT"
for file in "$REVIEW_QUEUE"/*.md; do
  [ -f "$file" ] || continue
  STATUS=$(grep "^status:" "$file" 2>/dev/null | head -1 | cut -d':' -f2 | tr -d ' ' || echo "")
  FILENAME=$(basename "$file")
  
  if [ "$STATUS" = "pending" ]; then
    echo "- $FILENAME" >> "$REPORT"
    COUNTS[pending]=$((COUNTS[pending] + 1))
  fi
done
[ ${COUNTS[pending]} -eq 0 ] && echo "(none)" >> "$REPORT"
echo "" >> "$REPORT"

# List approved
echo "## Approved (Ready to Promote)" >> "$REPORT"
for file in "$REVIEW_QUEUE"/*.md; do
  [ -f "$file" ] || continue
  STATUS=$(grep "^status:" "$file" 2>/dev/null | head -1 | cut -d':' -f2 | tr -d ' ' || echo "")
  FILENAME=$(basename "$file")
  
  if [ "$STATUS" = "approved" ]; then
    echo "- $FILENAME" >> "$REPORT"
    COUNTS[approved]=$((COUNTS[approved] + 1))
  fi
done
[ ${COUNTS[approved]} -eq 0 ] && echo "(none)" >> "$REPORT"
echo "" >> "$REPORT"

# List rejected
echo "## Rejected" >> "$REPORT"
for file in "$REVIEW_QUEUE"/*.md; do
  [ -f "$file" ] || continue
  STATUS=$(grep "^status:" "$file" 2>/dev/null | head -1 | cut -d':' -f2 | tr -d ' ' || echo "")
  FILENAME=$(basename "$file")
  
  if [ "$STATUS" = "rejected" ]; then
    echo "- $FILENAME" >> "$REPORT"
    COUNTS[rejected]=$((COUNTS[rejected] + 1))
  fi
done
[ ${COUNTS[rejected]} -eq 0 ] && echo "(none)" >> "$REPORT"
echo "" >> "$REPORT"

# Summary
echo "## Summary" >> "$REPORT"
echo "| Status | Count |" >> "$REPORT"
echo "|--------|-------|" >> "$REPORT"
echo "| pending | ${COUNTS[pending]} |" >> "$REPORT"
echo "| approved | ${COUNTS[approved]} |" >> "$REPORT"
echo "| rejected | ${COUNTS[rejected]} |" >> "$REPORT"
echo "" >> "$REPORT"

# Total notes in queue
TOTAL=$(ls "$REVIEW_QUEUE"/*.md 2>/dev/null | wc -l)
echo "**Total notes in queue:** $TOTAL" >> "$REPORT"

echo "Report: $REPORT"
