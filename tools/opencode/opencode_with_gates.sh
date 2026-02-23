#!/bin/bash
#
# opencode_with_gates.sh - Plankton-style write-time enforcement for OpenCode
#
# Usage: ./opencode_with_gates.sh [opencode_args...]
# Example: ./opencode_with_gates.sh --agent build --directory ./src -- "fix bug"
#
# Behavior:
# 1. Run OpenCode CLI with provided arguments
# 2. Run quality gates on any changed files
# 3. If gates fail (S0/S1), block and trigger remediation
# 4. Loop until quality passes or max retries exceeded
#

set -euo pipefail

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GATE_SCRIPT="${SCRIPT_DIR}/../quality/gate.sh"
MAX_RETRIES="${PLANKTON_MAX_RETRIES:-3}"
RETRY_COUNT=0
TIMESTAMP=$(date +%Y%m%d-%H%M%S)
OUTPUT_DIR="${PLANKTON_OUTPUT_DIR:-./outputs/quality/${TIMESTAMP}}"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Logging
log_info() { echo -e "${GREEN}[INFO]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

# Show usage
if [ $# -eq 0 ]; then
  echo "Usage: $0 [opencode_args...]"
  echo ""
  echo "Examples:"
  echo "  $0 --agent build -- \"implement feature\""
  echo "  $0 --agent edit --file src/main.ts -- \"fix type error\""
  echo ""
  echo "Environment variables:"
  echo "  PLANKTON_MAX_RETRIES (default: 3)"
  echo "  PLANKTON_OUTPUT_DIR  (default: ./outputs/quality/<timestamp>)"
  exit 1
fi

# Ensure output directory exists
mkdir -p "$OUTPUT_DIR"

# Track if we're running in a retry loop
IN_REMEDIATION=false

echo "=========================================="
echo "PLANKTON FOR OPENCODE - Quality Gates"
echo "=========================================="
echo ""

# Main execution loop
while true; do
  ((RETRY_COUNT++))
  
  if [ $RETRY_COUNT -gt 1 ]; then
    log_info "Remediation attempt $RETRY_COUNT/$MAX_RETRIES..."
    IN_REMEDIATION=true
  fi
  
  # ========================================
  # PHASE 0: Run OpenCode CLI
  # ========================================
  log_info "Running OpenCode CLI..."
  log_info "Command: opencode run $@"
  echo ""
  
  # Run OpenCode and capture exit code
  set +e
  opencode run "$@"
  OPENCODE_EXIT=$?
  set -e
  
  if [ $OPENCODE_EXIT -ne 0 ]; then
    log_error "OpenCode CLI failed with exit code $OPENCODE_EXIT"
    exit $OPENCODE_EXIT
  fi
  
  log_info "OpenCode CLI completed successfully"
  echo ""
  
  # ========================================
  # PHASE 1: Run Quality Gates
  # ========================================
  GATE_OUTPUT="${OUTPUT_DIR}/quality_report_${RETRY_COUNT}.json"
  
  log_info "Running quality gates..."
  log_info "Output: $GATE_OUTPUT"
  echo ""
  
  if [ ! -x "$GATE_SCRIPT" ]; then
    log_error "Gate script not found or not executable: $GATE_SCRIPT"
    exit 1
  fi
  
  set +e
  "$GATE_SCRIPT" --output "$GATE_OUTPUT"
  GATE_EXIT=$?
  set -e
  
  # ========================================
  # PHASE 2: Process Gate Results
  # ========================================
  log_info "Processing gate results..."
  
  if [ ! -f "$GATE_OUTPUT" ]; then
    log_error "Gate output not generated: $GATE_OUTPUT"
    exit 1
  fi
  
  # Extract summary from report
  STATUS=$(jq -r '.status // "unknown"' "$GATE_OUTPUT")
  S0_COUNT=$(jq -r '.summary.s0 // 0' "$GATE_OUTPUT")
  S1_COUNT=$(jq -r '.summary.s1 // 0' "$GATE_OUTPUT")
  S2_COUNT=$(jq -r '.summary.s2 // 0' "$GATE_OUTPUT")
  FILES_CHANGED=$(jq -r '.summary.files_changed // 0' "$GATE_OUTPUT")
  
  echo ""
  echo "=========================================="
  echo "GATE RESULTS (Attempt $RETRY_COUNT)"
  echo "=========================================="
  echo "Status: $STATUS"
  echo "S0 (Critical): $S0_COUNT"
  echo "S1 (Errors):   $S1_COUNT"
  echo "S2 (Style):    $S2_COUNT"
  echo "Files changed: $FILES_CHANGED"
  echo "=========================================="
  echo ""
  
  # ========================================
  # PHASE 3: Decision Logic
  # ========================================
  
  # PASS: No S0/S1 violations
  if [ "$STATUS" = "pass" ] && [ $S0_COUNT -eq 0 ] && [ $S1_COUNT -eq 0 ]; then
    log_info "✅ All quality gates passed!"
    log_info "Output: $GATE_OUTPUT"
    
    # Copy final report to canonical location
    cp "$GATE_OUTPUT" "${OUTPUT_DIR}/quality_report_final.json"
    
    echo ""
    echo "=========================================="
    echo "PLANKTON QUALITY CHECK: ✅ PASS"
    echo "=========================================="
    echo "Proceeding to commit..."
    
    # Calculate RL score
    RL_SCORE=$((95 + 5 - S2_COUNT - S3_COUNT))
    [ $RL_SCORE -gt 100 ] && RL_SCORE=100
    [ $RL_SCORE -lt 95 ] && RL_SCORE=95
    
    echo "RL Score: $RL_SCORE"
    echo ""
    
    exit 0
  fi
  
  # FAIL: S0/S1 violations detected
  log_error "❌ Quality gates failed!"
  log_error "S0: $S0_COUNT critical issues"
  log_error "S1: $S1_COUNT errors"
  echo ""
  
  # Show recommendations
  RECOMMENDATION=$(jq -r '.summary.recommendation // "Fix violations before proceeding"' "$GATE_OUTPUT")
  log_warn "Recommendation: $RECOMMENDATION"
  echo ""
  
  # Check if we've exceeded max retries
  if [ $RETRY_COUNT -ge $MAX_RETRIES ]; then
    log_error "❌ Max retries ($MAX_RETRIES) exceeded."
    log_error "Manual intervention required."
    echo ""
    echo "View full report: $GATE_OUTPUT"
    echo ""
    exit 1
  fi
  
  # ========================================
  # PHASE 4: Trigger Remediation (Ralph Loop)
  # ========================================
  log_warn "Triggering remediation (Ralph loop)..."
  
  # Generate remediation task
  REMEDIATION_TASK="${OUTPUT_DIR}/remediation_${RETRY_COUNT}.md"
  
  cat > "$REMEDIATION_TASK" << EOF
# Remediation Task - Attempt $RETRY_COUNT

## Quality Gate Failures
- S0 (Critical): $S0_COUNT
- S1 (Errors): $S1_COUNT

## Violations
$(jq -r '.violations[] | "- [\(.severity)] \(.file):\(.line) - \(.message)"' "$GATE_OUTPUT" 2>/dev/null || echo "No violations found")

## Commands to Run
$(jq -r '.commands_run[] | "- \(.)"' "$GATE_OUTPUT" 2>/dev/null || echo "See gate output")

## Remediation Instructions
1. Analyze each S0/S1 violation
2. Apply fixes using appropriate tools
3. Re-run: $0 $@
4. Repeat until gates pass

## Report
Full report: $GATE_OUTPUT
EOF
  
  log_info "Remediation task: $REMEDIATION_TASK"
  echo ""
  
  # Calculate RL score for failed state
  if [ $S0_COUNT -gt 0 ]; then
    RL_SCORE=$((60 - S0_COUNT * 10))
    [ $RL_SCORE -lt 0 ] && RL_SCORE=0
  elif [ $S1_COUNT -gt 0 ]; then
    RL_SCORE=$((79 - S1_COUNT))
    [ $RL_SCORE -lt 60 ] && RL_SCORE=60
  fi
  
  echo "RL Score: $RL_SCORE (Below threshold 95)"
  echo ""
  
  if [ "$IN_REMEDIATION" = true ]; then
    log_info "Re-running with fixes applied..."
  else
    log_info "First failure - initiating remediation..."
  fi
  
  echo ""
  sleep 2
  
done
