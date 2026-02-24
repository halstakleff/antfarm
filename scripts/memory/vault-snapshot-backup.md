#!/bin/bash
# vault-snapshot-backup.sh
# Create timestamped tar.gz snapshot of ClawOS-Vault

set -euo pipefail

VAULT_PATH="/Users/nit/.openclaw/workspace/ClawOS-Vault"
BACKUP_DIR="/Users/nit/.openclaw/workspace/backups/clawos"
REPORT_DIR="$VAULT_PATH/07-Outputs/agent-reports"
TIMESTAMP=$(date +%Y%m%d-%H%M%S)
SNAPSHOT_NAME="clawos-$TIMESTAMP.tar.gz"
SNAPSHOT_PATH="$BACKUP_DIR/$SNAPSHOT_NAME"

# Check _attachments size
ATTACH_SIZE=$(du -sm "$VAULT_PATH/_attachments" 2>/dev/null | awk '{print $1}' || echo "0")

# Build exclude list
EXCLUDE_OPTS="--exclude=.git"
if [ "$ATTACH_SIZE" -gt 500 ]; then
  EXCLUDE_OPTS="$EXCLUDE_OPTS --exclude=_attachments"
fi

# Create snapshot
tar -czf "$SNAPSHOT_PATH" -C "$VAULT_PATH/../" \
  $EXCLUDE_OPTS \
  $(basename "$VAULT_PATH")

# Clean old snapshots (keep last 14)
cd "$BACKUP_DIR"
ls -t clawos-*.tar.gz | tail -n +15 | xargs -r rm -f

# Update report
echo "## Backup Report - $TIMESTAMP" >> "$REPORT_DIR/BACKUP_REPORT.md"
echo "- Snapshot: $SNAPSHOT_NAME" >> "$REPORT_DIR/BACKUP_REPORT.md"
echo "- Size: $(du -h "$SNAPSHOT_PATH" | awk '{print $1}')" >> "$REPORT_DIR/BACKUP_REPORT.md"
echo "- Attachments: $ATTACH_SIZE MB ($([ "$ATTACH_SIZE" -gt 500 ] && echo "excluded" || echo "included"))" >> "$REPORT_DIR/BACKUP_REPORT.md"
echo "" >> "$REPORT_DIR/BACKUP_REPORT.md"

echo "Snapshot created: $SNAPSHOT_NAME"
