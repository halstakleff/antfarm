#!/bin/bash
# Title: Pruning Candidates Report
# Purpose: Identify candidates for archival (NO deletion)
# When to Run: Weekly via heartbeat
# Outputs: Report only, no deletion

set -euo pipefail

VAULT_PATH="/Users/nit/.openclaw/workspace/ClawOS-Vault"
REPORTS_PATH="$VAULT_PATH/07-Outputs/agent-reports"
TIMESTAMP=$(date +%Y%m%d-%H%M%S)
REPORT="$REPORTS_PATH/pruning-candidates-$TIMESTAMP.md"

echo "# Pruning Candidates Report - $TIMESTAMP" > "$REPORT"
echo "" >> "$REPORT"
echo "## Candidate Rules" >> "$REPORT"
echo "- last_updated > 90 days" >> "$REPORT"
echo "- retrieval: exclude" >> "$REPORT"
echo "- in archive folders" >> "$REPORT"
echo "" >> "$REPORT"
echo "## DO NOT DELETE - Review only" >> "$REPORT"

# List old files (candidates only)
find "$VAULT_PATH" -name "*.md" -mtime +90 -not -path "*/99-Archive/*" | head -20 >> "$REPORT" 2>/dev/null || true

echo "Report generated: $REPORT"
echo "NO DELETION performed - review manually"
