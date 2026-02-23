#!/bin/bash
#
# gate.sh - Plankton-style quality gate runner
#
# Runs comprehensive quality checks in strict order:
# 1. FORMAT (auto-fix)
# 2. LINT (collect violations)
# 3. TYPECHECK
# 4. TESTS
# 5. SECURITY
# 6. DOCS/YAML
#
# Outputs structured JSON report for RL scoring integration
#

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TIMESTAMP=$(date +%Y%m%d-%H%M%S)
OUTPUT_DIR="${1:-./outputs/quality/${TIMESTAMP}}"
REPORT_FILE="${OUTPUT_DIR}/quality_report.json"
LOG_FILE="${OUTPUT_DIR}/commands_run.log"
DIFF_FILE="${OUTPUT_DIR}/diff.patch"

# Track state
PHASE="INIT"
FILES_CHANGED=0
VIOLATIONS=()
AUTOFIXES=()
COMMANDS_RUN=()
TIMINGS=()
STACK_DETECTED=()
S0=0
S1=0
S2=0
S3=0

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log() { echo -e "${BLUE}[GATE]${NC} $1"; }
log_ok() { echo -e "${GREEN}[PASS]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error() { echo -e "${RED}[FAIL]${NC} $1"; }

# Ensure output directory
mkdir -p "$OUTPUT_DIR"

# JSON helper functions
json_array_start() { echo "["; }
json_array_end() { echo "]"; }
json_add_string() { echo "  \"$1\": \"$2\","; }
json_add_number() { echo "  \"$1\": $2,"; }
json_add_bool() { echo "  \"$1\": $2,"; }

# Detect project stack
detect_stack() {
  log "Detecting project stack..."
  
  if [ -f "package.json" ]; then
    STACK_DETECTED+=("js")
    log "  Found: JavaScript/Node.js"
  fi
  
  if [ -f "next.config.js" ] && [ -f "next.config.ts" ]; then
    STACK_DETECTED+=("next")
    log "  Found: Next.js"
  fi
  
  if [ -f "tsconfig.json" ]; then
    STACK_DETECTED+=("ts")
    log "  Found: TypeScript"
  fi
  
  if [ -f "pyproject.toml" ] || [ -f "requirements.txt" ]; then
    STACK_DETECTED+=("python")
    log "  Found: Python"
  fi
  
  if [ -f "Cargo.toml" ]; then
    STACK_DETECTED+=("rust")
    log "  Found: Rust"
  fi
  
  if [ -f "go.mod" ]; then
    STACK_DETECTED+=("go")
    log "  Found: Go"
  fi
  
  if [ -f "Dockerfile" ]; then
    STACK_DETECTED+=("docker")
    log "  Found: Docker"
  fi
  
  # Check for docs/markdown
  if ls *.md >/dev/null 2>&1; then
    STACK_DETECTED+=("docs")
    log "  Found: Markdown docs"
  fi
  
  # Check for YAML files
  if ls *.yml *.yaml >/dev/null 2>&1; then
    STACK_DETECTED+=("yaml")
    log "  Found: YAML files"
  fi
  
  if [ ${#STACK_DETECTED[@]} -eq 0 ]; then
    log_warn "  No recognized stack detected"
    STACK_DETECTED+=("unknown")
  fi
  
  log "Detected: ${STACK_DETECTED[*]}"
  echo ""
}

# Run command with timing
run_with_timing() {
  local name="$1"
  shift
  local start_time=$(date +%s%N)
  local cmd_str="$*"
  
  log "Running: $name"
  echo "  $cmd_str"
  
  set +e
  "$@" >"${OUTPUT_DIR}/${name}.log" 2>&1
  local exit_code=$?
  set -e
  
  local end_time=$(date +%s%N)
  local duration_ms=$(( (end_time - start_time) / 1000000 ))
  
  TIMINGS+=("\"$name\": $duration_ms")
  COMMANDS_RUN+=("$cmd_str")
  
  if [ $exit_code -eq 0 ]; then
    log_ok "  $name passed (${duration_ms}ms)"
  else
    log_error "  $name failed (${duration_ms}ms, exit $exit_code)"
  fi
  
  return $exit_code
}

# ========================================
# PHASE 1: FORMAT (Auto-fix enabled)
# ========================================
run_phase_1_format() {
  PHASE="FORMAT"
  log "========================================="
  log "PHASE 1: FORMAT (Auto-fix enabled)"
  log "========================================="
  echo ""
  
  local changes_before=$(git diff --name-only 2>/dev/null | wc -l)
  
  # TypeScript/JavaScript formatting
  if [[ " ${STACK_DETECTED[*]} " =~ " ts " ]] || [[ " ${STACK_DETECTED[*]} " =~ " js " ]]; then
    # Biome formatting (preferred)
    if command -v biome >/dev/null 2>&1; then
      if run_with_timing "biome_format" biome format --write .; then
        AUTOFIXES+=("{\"tool\": \"biome\", \"action\": \"format\", \"files\": []}")
      fi
    # Prettier fallback
    elif [ -f ".prettierrc" ] && command -v npx >/dev/null 2>&1; then
      if run_with_timing "prettier" npx prettier --write .; then
        AUTOFIXES+=("{\"tool\": \"prettier\", \"action\": \"format\", \"files\": []}")
      fi
    fi
  fi
  
  # Python formatting
  if [[ " ${STACK_DETECTED[*]} " =~ " python " ]]; then
    if command -v ruff >/dev/null 2>&1; then
      if run_with_timing "ruff_format" ruff format .; then
        AUTOFIXES+=("{\"tool\": \"ruff\", \"action\": \"format\", \"files\": []}")
      fi
    elif command -v black >/dev/null 2>&1; then
      if run_with_timing "black" black .; then
        AUTOFIXES+=("{\"tool\": \"black\", \"action\": \"format\", \"files\": []}")
      fi
    fi
  fi
  
  # Shell formatting
  if command -v shfmt >/dev/null 2>&1; then
    run_with_timing "shfmt" shfmt -w . || true
  fi
  
  # Markdown formatting
  if [[ " ${STACK_DETECTED[*]} " =~ " docs " ]]; then
    if command -v markdownlint >/dev/null 2>&1; then
      run_with_timing "markdownlint_fix" markdownlint --fix . || true
    fi
  fi
  
  # Check for changes
  local changes_after=$(git diff --name-only 2>/dev/null | wc -l)
  if [ $changes_after -gt $changes_before ]; then
    ((FILES_CHANGED += changes_after - changes_before))
    log_warn "Phase 1 applied auto-fixes to $((changes_after - changes_before)) files"
    
    # Stage changes
    git add . 2>/dev/null || true
    
    # Generate diff
    git diff --cached > "$DIFF_FILE" 2>/dev/null || echo "" > "$DIFF_FILE"
  fi
  
  S2=$((changes_after - changes_before))
  
  log_ok "Phase 1 complete"
  echo ""
}

# ========================================
# PHASE 2: LINT (Violation detection)
# ========================================
run_phase_2_lint() {
  PHASE="LINT"
  log "========================================="
  log "PHASE 2: LINT (Violation detection)"
  log "========================================="
  echo ""
  
  # TypeScript/JavaScript linting
  if [[ " ${STACK_DETECTED[*]} " =~ " ts " ]] || [[ " ${STACK_DETECTED[*]} " =~ " js " ]]; then
    # Biome linting
    if command -v biome >/dev/null 2>&1; then
      if ! run_with_timing "biome_lint" biome lint .; then
        ((S1++))
        parse_biome_output
      fi
    fi
    
    # ESLint
    if [ -f ".eslintrc.js" ] || [ -f ".eslintrc.json" ]; then
      if command -v npx >/dev/null 2>&1; then
        if ! run_with_timing "eslint" npx eslint .; then
          ((S1++))
        fi
      fi
    fi
  fi
  
  # Python linting
  if [[ " ${STACK_DETECTED[*]} " =~ " python " ]]; then
    if command -v ruff >/dev/null 2>&1; then
      if ! run_with_timing "ruff_check" ruff check .; then
        ((S1++))
      fi
    fi
    
    if command -v vulture >/dev/null 2>&1; then
      run_with_timing "vulture" vulture . || ((S2++))
    fi
    
    if command -v bandit >/dev/null 2>&1; then
      if ! run_with_timing "bandit" bandit -r .; then
        ((S1++))
      fi
    fi
  fi
  
  # Dead code detection (JavaScript/TypeScript)
  if [ -f "package.json" ] && command -v npx >/dev/null 2>&1; then
    if command -v knip >/dev/null 2>&1; then
      run_with_timing "knip" knip || ((S2++))
    fi
  fi
  
  # Shell linting
  if command -v shellcheck >/dev/null 2>&1; then
    find . -name "*.sh" -type f -exec shellcheck {} + >"${OUTPUT_DIR}/shellcheck.log" 2>&1 || ((S1++))
  fi
  
  # Docker linting
  if [[ " ${STACK_DETECTED[*]} " =~ " docker " ]]; then
    if command -v hadolint >/dev/null 2>&1; then
      find . -name "Dockerfile" -type f -exec hadolint {} + >"${OUTPUT_DIR}/hadolint.log" 2>&1 || ((S2++))
    fi
  fi
  
  log_ok "Phase 2 complete"
  echo ""
}

# ========================================
# PHASE 3: TYPECHECK
# ========================================
run_phase_3_typecheck() {
  PHASE="TYPECHECK"
  log "========================================="
  log "PHASE 3: TYPECHECK (No auto-fix)"
  log "========================================="
  echo ""
  
  # TypeScript type checking
  if [[ " ${STACK_DETECTED[*]} " =~ " ts " ]]; then
    if [ -f "tsconfig.json" ]; then
      if command -v tsc >/dev/null 2>&1; then
        if ! run_with_timing "tsc" tsc --noEmit; then
          ((S0++))
          VIOLATIONS+=("{\"severity\": \"S0\", \"tool\": \"tsc\", \"message\": \"TypeScript type errors\"}")
        fi
      fi
    fi
    
    if command -v pyright >/dev/null 2>&1; then
      if ! run_with_timing "pyright" pyright; then
        ((S0++))
      fi
    fi
  fi
  
  # Python type checking
  if [[ " ${STACK_DETECTED[*]} " =~ " python " ]]; then
    if command -v mypy >/dev/null 2>&1; then
      if ! run_with_timing "mypy" mypy .; then
        ((S1++))
      fi
    fi
  fi
  
  # Rust type checking
  if [[ " ${STACK_DETECTED[*]} " =~ " rust " ]]; then
    if command -v cargo >/dev/null 2>&1; then
      if ! run_with_timing "cargo_check" cargo check; then
        ((S0++))
      fi
    fi
  fi
  
  # Go type checking
  if [[ " ${STACK_DETECTED[*]} " =~ " go " ]]; then
    if command -v go >/dev/null 2>&1; then
      if ! run_with_timing "go_build" go build ./...; then
        ((S0++))
      fi
    fi
  fi
  
  log_ok "Phase 3 complete"
  echo ""
}

# ========================================
# PHASE 4: TESTS
# ========================================
run_phase_4_tests() {
  PHASE="TESTS"
  log "========================================="
  log "PHASE 4: TESTS"
  log "========================================="
  echo ""
  
  # JavaScript/TypeScript tests
  if [ -f "package.json" ]; then
    if grep -q '"test"' package.json 2>/dev/null; then
      if command -v npm >/dev/null 2>&1; then
        if ! run_with_timing "npm_test" npm test; then
          ((S0++))
          VIOLATIONS+=("{\"severity\": \"S0\", \"tool\": \"npm\", \"message\": \"Test failures\"}")
        fi
      fi
    fi
  fi
  
  # Python tests
  if [[ " ${STACK_DETECTED[*]} " =~ " python " ]]; then
    if command -v pytest >/dev/null 2>&1; then
      if ! run_with_timing "pytest" pytest; then
        ((S0++))
      fi
    fi
  fi
  
  # Rust tests
  if [[ " ${STACK_DETECTED[*]} " =~ " rust " ]]; then
    if command -v cargo >/dev/null 2>&1; then
      if ! run_with_timing "cargo_test" cargo test; then
        ((S0++))
      fi
    fi
  fi
  
  log_ok "Phase 4 complete"
  echo ""
}

# ========================================
# PHASE 5: SECURITY
# ========================================
run_phase_5_security() {
  PHASE="SECURITY"
  log "========================================="
  log "PHASE 5: SECURITY"
  log "========================================="
  echo ""
  
  # Semgrep for multi-language security
  if command -v semgrep >/dev/null 2>&1; then
    if ! run_with_timing "semgrep" semgrep --config=auto .; then
      ((S1++))
    fi
  fi
  
  # Dependency scanning (Node.js)
  if [ -f "package.json" ]; then
    if command -v npm >/dev/null 2>&1; then
      run_with_timing "npm_audit" npm audit || ((S2++))
    fi
  fi
  
  # Dependency scanning (Python)
  if [[ " ${STACK_DETECTED[*]} " =~ " python " ]]; then
    if command -v safety >/dev/null 2>&1; then
      run_with_timing "safety" safety check || ((S2++))
    fi
  fi
  
  log_ok "Phase 5 complete"
  echo ""
}

# ========================================
# PHASE 6: DOCS/YAML
# ========================================
run_phase_6_docs() {
  PHASE="DOCS"
  log "========================================="
  log "PHASE 6: DOCS/YAML SANITY"
  log "========================================="
  echo ""
  
  # Markdown linting
  if [[ " ${STACK_DETECTED[*]} " =~ " docs " ]]; then
    if command -v markdownlint >/dev/null 2>&1; then
      run_with_timing "markdownlint" markdownlint . || ((S3++))
    fi
  fi
  
  # YAML linting
  if [[ " ${STACK_DETECTED[*]} " =~ " yaml " ]]; then
    if command -v yamllint >/dev/null 2>&1; then
      run_with_timing "yamllint" yamllint . || ((S2++))
    fi
  fi
  
  log_ok "Phase 6 complete"
  echo ""
}

# Generate final JSON report
generate_report() {
  log "Generating quality report..."
  
  local status="pass"
  local recommendation="All quality gates passed"
  
  if [ $S0 -gt 0 ]; then
    status="fail"
    recommendation="S0 violations ($S0) - Fix critical failures before proceeding"
  elif [ $S1 -gt 0 ]; then
    status="fail"
    recommendation="S1 violations ($S1) - Fix errors before proceeding"
  fi
  
  # Build JSON report
  cat > "$REPORT_FILE" << EOF
{
  "status": "$status",
  "timestamp": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
  "stack_detected": [$(printf '"%s",' "${STACK_DETECTED[@]}" | sed 's/,$//')],
  "autofixes_applied": [$(printf '%s,' "${AUTOFIXES[@]}" | sed 's/,$//')],
  "violations": [$(printf '%s,' "${VIOLATIONS[@]}" | sed 's/,$//')],
  "summary": {
    "s0": $S0,
    "s1": $S1,
    "s2": $S2,
    "s3": $S3,
    "files_changed": $FILES_CHANGED,
    "recommendation": "$recommendation"
  },
  "commands_run": [$(printf '"%s",' "${COMMANDS_RUN[@]}" | sed 's/,$//')],
  "timings_ms": {${TIMINGS[*]}}
}
EOF
  
  log_ok "Report: $REPORT_FILE"
}

# Main execution
main() {
  log "========================================="
  log "PLANKTON QUALITY GATE RUNNER"
  log "========================================="
  log "Output: $OUTPUT_DIR"
  echo ""
  
  detect_stack
  
  run_phase_1_format
  
  # Re-check auto-fixes
  if [ ${#AUTOFIXES[@]} -gt 0 ]; then
    log_warn "Re-running Phase 1 to confirm fixes..."
    run_phase_1_format
  fi
  
  run_phase_2_lint
  run_phase_3_typecheck
  run_phase_4_tests
  run_phase_5_security
  run_phase_6_docs
  
  generate_report
  
  # Final summary
  echo ""
  echo "========================================="
  if [ $S0 -eq 0 ] && [ $S1 -eq 0 ]; then
    echo -e "${GREEN}QUALITY GATE: PASS${NC}"
    echo "========================================="
    exit 0
  else
    echo -e "${RED}QUALITY GATE: FAIL${NC}"
    echo "========================================="
    echo "S0: $S0 | S1: $S1 | S2: $S2 | S3: $S3"
    exit 1
  fi
}

# Handle output flag
if [ "${1:-}" = "--output" ]; then
  OUTPUT_DIR="$2"
  REPORT_FILE="${OUTPUT_DIR}/quality_report.json"
  LOG_FILE="${OUTPUT_DIR}/commands_run.log"
  DIFF_FILE="${OUTPUT_DIR}/diff.patch"
  shift 2
fi

# Run main
main "${@}"
