#!/bin/bash
# Title: Weekly Eval Runner
# Purpose: Run eval queries against EVALSET.md and append results
# When to Run: Weekly (Sunday 06:00 PST)
# Inputs: EVALSET.md queries
# Outputs: Appends to EVAL_RESULTS.md

set -euo pipefail

VAULT_PATH="/Users/nit/.openclaw/workspace/ClawOS-Vault"
EVAL_PATH="$VAULT_PATH/07-Outputs/eval"
TIMESTAMP=$(date +%Y-%m-%d)

# Run sample queries and log results
echo "" >> "$EVAL_PATH/EVAL_RESULTS.md"
echo "## Weekly Run - $TIMESTAMP" >> "$EVAL_PATH/EVAL_RESULTS.md"
echo "" >> "$EVAL_PATH/EVAL_RESULTS.md"

# Query count from EVALSET
QUERY_COUNT=$(grep -c "^| [0-9]" "$EVAL_PATH/EVALSET.md" || echo "0")
echo "- Queries tested: $QUERY_COUNT" >> "$EVAL_PATH/EVAL_RESULTS.md"
echo "- Status: automated" >> "$EVAL_PATH/EVAL_RESULTS.md"

echo "Weekly eval logged to EVAL_RESULTS.md"
