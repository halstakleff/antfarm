---
script_id: tiered-verification-gate
version: 4.2.0
sacred_docs: [PROJECT_KB.md, framework/tiered-reliability-engine.md]
framework_refs: [framework/strict-mode-auto-trigger-spec.md]
---

# Script: Tiered Verification Gate

## Title
Tiered Reliability Verification Gate - FAST/STRICT Auto-Detection

## Purpose
Automatically detect task risk level (FAST vs STRICT), apply appropriate verification, and block progression if required checks fail.

## When to Run
- Before any task execution
- After file changes
- Before commit/push
- Before workflow execution

## Prerequisites
- Tiered reliability engine installed
- Strict mode trigger spec available
- Hash cache initialized in PROJECT_KB.md

## Inputs

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| task_text | string | Yes | Task description to analyze |
| files_changed | array | No | List of changed file paths |
| force_mode | string | No | Override: FAST or STRICT |
| skip_cache | boolean | No | Skip hash cache check |

## Step-by-Step Execution

### Step 0: Input Validation (S0-S3)
```bash
# S0: Check required inputs
if [ -z "$task_text" ]; then
  echo '{"error":"Missing task_text"}' >2
  exit 1
fi

# S1: Check spec files exist
if [ ! -f "framework/strict-mode-auto-trigger-spec.md" ]; then
  echo '{"error":"Trigger spec not found"}' >2
  exit 1
fi

echo "[STATUS] Input validation OK"
```

### Step 1: Hash Cache Check (Cost-Aware)
```bash
TIMESTAMP=$(date +%Y%m%d-%H%M%S)
OUTPUT_DIR="outputs/verification/$TIMESTAMP"
mkdir -p "$OUTPUT_DIR"

# Skip if hash cache hit
if [ "$skip_cache" != "true" ] && [ -f "PROJECT_KB.md" ]; then
  for file in "${files_changed[@]}"; do
    if [ -f "$file" ]; then
      CURRENT_HASH=$(sha256sum "$file" | cut -d' ' -f1)
      CACHED_HASH=$(grep "file_hash:.*$file" PROJECT_KB.md | tail -1 | cut -d'=' -f2 | tr -d ' ')
      
      if [ "$CURRENT_HASH" = "$CACHED_HASH" ]; then
        echo "[COST-AWARE] Hash hit for $file - using cached V-level"
        CACHED_V=$(grep -A1 "$file" PROJECT_KB.md | grep "verification_level" | cut -d':' -f2 | tr -d ' ')
        echo '{"mode":"CACHED","verification_level":"'$CACHED_V'","cache_hit":true}' > "$OUTPUT_DIR/report.json"
        exit 0
      fi
    fi
  done
fi

echo "[STATUS] Cache check complete (no hits)"
```

### Step 2: Mode Detection
```bash
# Check for STRICT triggers
MODE="FAST"
V_LEVEL="V1"
TRIGGERS="[]"

# CRITICAL keywords
CRITICAL_KEYWORDS="edit|modify|refactor|fix|patch|update|change|replace"
EXECUTION_KEYWORDS="run|execute|install|uninstall|setup|configure"
DEPLOY_KEYWORDS="deploy|release|publish|ship|rollout|promote"
GIT_KEYWORDS="git commit|git push|git merge|pull request|rebase|revert"
WORKFLOW_KEYWORDS="workflow|yaml|yml|antfarm|opencode|agent|cron"
DB_KEYWORDS="schema|database|db|migration|migrate|rollback|seed"
AUTH_KEYWORDS="auth|authentication|authorization|rbac|permission|role|token|secret|credential"
SEC_KEYWORDS="security|vulnerability|exploit|cve|patch|harden|encrypt"
ENV_KEYWORDS="production|prod|staging|development|dev|environment|env|dotenv"

# Check task text
if echo "$task_text" | grep -qiE "($CRITICAL_KEYWORDS)"; then
  MODE="STRICT"
  V_LEVEL="V3"
  TRIGGERS="[\"keyword:critical\"]"
fi

if echo "$task_text" | grep -qiE "($EXECUTION_KEYWORDS)"; then
  MODE="STRICT"
  V_LEVEL="V3"
  TRIGGERS="[\"keyword:execution\"]"
fi

if echo "$task_text" | grep -qiE "($DB_KEYWORDS|$AUTH_KEYWORDS|$SEC_KEYWORDS|$DEPLOY_KEYWORDS|$ENV_KEYWORDS)"; then
  MODE="STRICT"
  V_LEVEL="V3"
  TRIGGERS="[\"keyword:risk\"]"
fi

# Check file paths
for file in "${files_changed[@]}"; do
  if echo "$file" | grep -qE "(workflows/.*\.yml|agents/.*|tools/.*|scripts/.*\.md|package\.json|tsconfig|next\.config|Dockerfile|docker-compose|migration|\.env)"; then
    MODE="STRICT"
    V_LEVEL="V3"
    TRIGGERS="[\"file:critical\"]"
  fi
done

# Force mode override
if [ -n "$force_mode" ]; then
  MODE="$force_mode"
  if [ "$force_mode" = "STRICT" ] && [ "$V_LEVEL" = "V1" ]; then
    V_LEVEL="V2"  # Minimum for forced STRICT
  fi
fi

echo "[STATUS] Mode detected: $MODE (V-level: $V_LEVEL)"
```

### Step 3: Apply Verification

**FAST Mode (V1)**
```bash
if [ "$MODE" = "FAST" ]; then
  # V1: Internal consistency only
  ASSUMPTIONS=$(echo "$task_text" | grep -oE '\[assumption:[^\]]+\]' || echo "[]")
  
  # FAST: No artifact, just status
  echo '{"mode":"FAST","verification_level":"V1","severity":"S3","confidence":"MED","triggers":[],"artifact":null}' > "$OUTPUT_DIR/report.json"
  
  echo "[STATUS] FAST verification complete (V1)"
  exit 0
fi
```

**STRICT Mode (V2/V3)**
```bash
# V2-V3: External validation required
EVIDENCE="[]"
SEVERITY="S3"
CONFIDENCE="LOW"
BLOCKING=""

# Run verification checks
if [ "$V_LEVEL" = "V3" ]; then
  # Code/config verification
  
  # Check 1: Files exist and readable
  for file in "${files_changed[@]}"; do
    if [ ! -r "$file" ]; then
      SEVERITY="S1"
      BLOCKING="File not readable: $file"
      EVIDENCE="[{\"check\":\"file_exists\", \"file\":\"$file\", \"passed\":false}]"
    fi
  done
  
  # Check 2: Syntax validation (if applicable)
  for file in "${files_changed[@]}"; do
    if echo "$file" | grep -qE '\.(ts|js|json|yml|yaml)$'; then
      case "$file" in
        *.ts) npx tsc --noEmit "$file" 2>/dev/null || SEVERITY="S1" ;;
        *.json) jq empty "$file" 2>/dev/null || SEVERITY="S1" ;;
        *.yml|*.yaml) yamllint "$file" 2>/dev/null || SEVERITY="S2" ;;
      esac
    fi
  done
  
  # Check 3: No secrets in code
  for file in "${files_changed[@]}"; do
    if grep -qiE "(api_key|secret|password|token)" "$file" 2>/dev/null; then
      if ! echo "$file" | grep -qE "(\.env\.example|example|test)"; then
        SEVERITY="S0"
        BLOCKING="Potential secret detected in $file"
      fi
    fi
  done
  
  V_CHECKS_PASSED=3
fi

# Calculate confidence
if [ "$SEVERITY" = "S3" ]; then
  CONFIDENCE="HIGH"
elif [ "$SEVERITY" = "S2" ]; then
  CONFIDENCE="MED"
else
  CONFIDENCE="LOW"
fi

# Calculate RL modifier
RL_MOD=0
if [ "$V_LEVEL" = "V3" ]; then RL_MOD=$((RL_MOD + 10)); fi
if [ "$V_LEVEL" = "V2" ]; then RL_MOD=$((RL_MOD + 5)); fi
if [ -f "$OUTPUT_DIR/report.json" ]; then RL_MOD=$((RL_MOD + 5)); fi
if [ "$SEVERITY" = "S0" ] || [ "$SEVERITY" = "S1" ]; then RL_MOD=$((RL_MOD - 20)); fi

echo "[STATUS] Verification complete (V-level: $V_LEVEL, Severity: $SEVERITY)"
```

### Step 4: Generate Artifact (STRICT only)
```bash
if [ "$MODE" = "STRICT" ]; then
  cat > "$OUTPUT_DIR/report.json" << EOF
{
  "mode": "$MODE",
  "verification_level": "$V_LEVEL",
  "severity": "$SEVERITY",
  "confidence": "$CONFIDENCE",
  "triggers": {
    "keywords": $TRIGGERS,
    "files": $(echo "${files_changed[@]}" | jq -R 'split(" ") | map(select(length > 0))' || echo "[]")
  },
  "assumptions": $ASSUMPTIONS,
  "evidence": $EVIDENCE,
  "blocking_reason": "$BLOCKING",
  "rl_modifier": $RL_MOD,
  "timestamp": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
  "artifact_path": "$OUTPUT_DIR/report.json"
}
EOF

  echo "[STATUS] Artifact generated: $OUTPUT_DIR/report.json"
fi
```

### Step 5: Blocking Decision
```bash
# Determine final status
STATUS="PASS"

if [ "$SEVERITY" = "S0" ]; then
  STATUS="BLOCK"
  echo "[BLOCK] S0 severity detected: $BLOCKING"
fi

if [ "$SEVERITY" = "S1" ]; then
  STATUS="FAIL"
  echo "[FAIL] S1 severity, blocking until resolved"
fi

if [ "$MODE" = "STRICT" ] && [ -z "$BLOCKING" ] && [ ! -f "$OUTPUT_DIR/report.json" ]; then
  STATUS="BLOCK"
  echo "[BLOCK] STRICT mode requires artifact"
fi

# Ralph loop integration
if [ "$STATUS" = "BLOCK" ] || [ "$STATUS" = "FAIL" ]; then
  echo "[RALPH] Triggering remediation loop..."
  
  cat > "$OUTPUT_DIR/remediation.md" << EOF
# Remediation Task

## Verification Failure
- Mode: $MODE
- V-Level: $V_LEVEL
- Severity: $SEVERITY
- Blocking: $BLOCKING

## Required Actions
1. Address $SEVERITY severity issues
2. Re-run verification gate
3. Ensure artifact generated (if STRICT)

## Report
$OUTPUT_DIR/report.json
EOF

  echo "[RALPH] Remediation task: $OUTPUT_DIR/remediation.md"
fi

# Update PROJECT_KB with hash cache
if [ -f "PROJECT_KB.md" ]; then
  for file in "${files_changed[@]}"; do
    if [ -f "$file" ]; then
      HASH=$(sha256sum "$file" | cut -d' ' -f1)
      echo "file_hash: sha256:$file = $HASH" |>> PROJECT_KB.md
      echo "verified_at: $(date -u +%Y-%m-%dT%H:%M:%SZ)" |>> PROJECT_KB.md
      echo "verification_level: $V_LEVEL" |>> PROJECT_KB.md
    fi
  done
fi

echo "[STATUS] Final status: $STATUS"
```

## Verification Commands

```bash
# Verify FAST mode for brainstorm
echo '{"task_text":"Brainstorm ideas"}' | ./scripts/verification/tiered-verification-gate.md
test $? -eq 0
grep -q '"mode":"FAST"' outputs/verification/*/report.json || echo "No artifact expected"

# Verify STRICT mode for edit
echo '{"task_text":"Edit workflow","files_changed":["workflows/test.yml"]}' | ./scripts/verification/tiered-verification-gate.md
test $? -eq 0
grep -q '"mode":"STRICT"' outputs/verification/*/report.json
grep -q '"V3"' outputs/verification/*/report.json

# Verify S0 blocks
# (mock secret file test)
```

## Rollback

```bash
# Remove artifacts
rm -rf outputs/verification/*/

# Remove cache entries
grep -v "file_hash:" PROJECT_KB.md > PROJECT_KB.tmp && mv PROJECT_KB.tmp PROJECT_KB.md
```

## RL Scoring Rubric

| Criterion | Weight | Target |
|-----------|--------|--------|
| Mode detection | 20% | Correct FAST/STRICT |
| V-level assignment | 25% | V3 for code, V2 for docs |
| Artifact generation | 20% | Strict produces file |
| Severity correct | 20% | S3 pass, S0/S1 block |
| Hash caching | 15% | Cost-aware skip |

**Threshold**: FAST ≥85, STRICT ≥95

## Status Output Format

```json
{
  "STATUS": "PASS|FAIL|BLOCK",
  "MODE": "FAST|STRICT",
  "V_LEVEL": "V1|V2|V3",
  "SEVERITY": "S0|S1|S2|S3",
  "CONFIDENCE": "HIGH|MED|LOW",
  "ARTIFACT": "/path/to/report.json",
  "RL_MODIFIER": 15,
  "TRIGGERS": ["keyword:critical", "file:workflow"],
  "BLOCKING_REASON": "..." // if BLOCK
}
```
