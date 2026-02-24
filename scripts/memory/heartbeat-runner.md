#!/bin/bash
# Title: Heartbeat Runner
# Purpose: Execute daily memory maintenance routines
# When to Run: Daily at 06:00 PST via cron
# Prerequisites: QMD installed, vault accessible
# Inputs: None
# Outputs: HEALTH snapshot, logs to 07-Outputs/agent-reports/

set -euo pipefail

VAULT_PATH="/Users/nit/.openclaw/workspace/ClawOS-Vault"
REPORTS_PATH="$VAULT_PATH/07-Outputs/agent-reports"
TIMESTAMP=$(date +%Y%m%d-%H%M%S)

# Daily retrieval health snapshot
echo "[$(date)] Starting heartbeat..." >> "$REPORTS_PATH/heartbeat.log"

# Run schema drift scan
qmd collection list > "$REPORTS_PATH/schema-$TIMESTAMP.txt" 2>&1 || true

# Update HEALTH.md with timestamp
sed -i '' "s/Last run: .*/Last run: $(date +%Y-%m-%d)/" "$VAULT_PATH/HEALTH.md" || true

echo "[$(date)] Heartbeat complete" >> "$REPORTS_PATH/heartbeat.log"
