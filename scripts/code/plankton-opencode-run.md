---
script_id: plankton-opencode-run
version: 1.0.0
sacred_docs: [PROJECT_KB.md]
framework_refs: [framework/plankton-behavior-contract.md]
---

# Script: Plankton OpenCode Run

## Title
Plankton for OpenCode - Execute Task with Quality Gates

## Purpose
Run an OpenCode task with enforced quality gates. Block on S0/S1 violations.

## When to Run
- Every code edit task
- Before commits
- CI/CD pipeline

## Prerequisites
- Plankton setup complete (see plankton-opencode-setup.md)
- Working directory with changes

## Inputs

| Field | Type | Required | Default |
|-------|------|----------|---------|
| task | string | Yes | - |
| agent | string | No | build |
| directory | string | No | . |
| max_retries | number | No | 3 |

## Step-by-Step Execution

### Step 0: Pre-flight Check
```bash
# S0: Verify gate components exist
for f in tools/opencode/opencode_with_gates.sh tools/quality/gate.sh; do
  [ -x "$f" ] || { echo "ERROR: $f missing"; exit 1; }
done

# S1: Verify git status clean-ish
if [ -z "$(git status --porcelain 2>/dev/null)" ]; then
  echo "WARN: No changes to validate"
fi

echo "[STATUS] Pre-flight OK"
```

### Step 1: Execute with Gates
```bash
# Use OpenCode CLI with wrapper
opencode run --agent "$agent" "$task"

# Alternative: direct wrapper
./tools/opencode/opencode_with_gates.sh \
  --agent "$agent" \
  --directory "$directory" \
  -- "$task"
```

### Step 2: Process Gate Output
```bash
TIMESTAMP=$(date +%Y%m%d-%H%M%S)
GATE_OUT="outputs/quality/$TIMESTAMP"

# Extract results
STATUS=$(jq -r '.status' "$GATE_OUT/quality_report.json")
S0=$(jq -r '.summary.s0' "$GATE_OUT/quality_report.json")
S1=$(jq -r '.summary.s1' "$GATE_OUT/quality_report.json")
S2=$(jq -r '.summary.s2' "$GATE_OUT/quality_report.json")
S3=$(jq -r '.summary.s3' "$GATE_OUT/quality_report.json")

echo "Gate result: $STATUS (S0=$S0, S1=$S1)"
```

### Step 3: Handle Results

```bash
# PASS: No S0/S1
if [ "$STATUS" = "pass" ] && [ "$S0" -eq 0 ] && [ "$S1" -eq 0 ]; then
  echo "[STATUS] ✅ Quality gates PASSED"
  RL_SCORE=$((95 + 5 - S2 - S3))
  [ $RL_SCORE -gt 100 ] && RL_SCORE=100
fi

# FAIL: S0/S1 present
if [ "$S0" -gt 0 ] || [ "$S1" -gt 0 ]; then
  echo "[STATUS] ❌ Quality gates FAILED"
  
  if [ "$S0" -gt 0 ]; then
    RL_SCORE=$((60 - S0 * 10))
    [ $RL_SCORE -lt 0 ] && RL_SCORE=0
  else
    RL_SCORE=$((79 - S1))
    [ $RL_SCORE -lt 60 ] && RL_SCORE=60
  fi
  
  # Show violations
  jq -r '.violations[] | select(.severity == "S0" or .severity == "S1")' \
    "$GATE_OUT/quality_report.json"
fi
```

### Step 4: Update PROJECT_KB.md
```bash
# Log gate run
jq -n \
  --arg ts "$TIMESTAMP" \
  --arg task "$task" \
  --arg status "$STATUS" \
  --argjson s0 "$S0" \
  --argjson s1 "$S1" \
  --argjson rl "$RL_SCORE" \
  '{timestamp: $ts, task: $task, status: $status, s0: $s0, s1: $s1, rl_score: $rl}' \
  >> PROJECT_KB.md
```

## Verification Commands

```bash
# Verify gate output exists
test -f outputs/quality/*/quality_report.json

# Validate JSON
jq empty outputs/quality/*/quality_report.json

# Check RL score
jq -r '.rl_score' outputs/quality/*/quality_report.json

# Verify no S0/S1 on pass
jq -e '.summary.s0 == 0 and .summary.s1 == 0' outputs/quality/*/quality_report.json

# Check PROJECT_KB updated
grep -q "rl_score" PROJECT_KB.md
```

## Rollback

```bash
# Restore from auto-fixes
git checkout -- .

# Remove gate output
rm -rf outputs/quality/*/
```

## RL Scoring Rubric

| Criterion | Weight | Target |
|-----------|--------|--------|
| Task executed | 20% | Exit 0 |
| Gate ran | 20% | Report exists |
| S0 = 0 | 25% | Pass required |
| S1 = 0 | 25% | Pass required |
| Report valid | 10% | JSON valid |

**Threshold**: ≥95

## Status Output Format

```json
{
  "STATUS": "COMPLETE|FAILED",
  "FILES_MODIFIED": ["src/main.ts", "PROJECT_KB.md"],
  "COMMANDS_RUN": [
    "opencode run --agent build",
    "tools/quality/gate.sh"
  ],
  "TEST_RESULTS": {
    "gate_status": "pass",
    "s0": 0,
    "s1": 0,
    "s2": 2,
    "s3": 1
  },
  "RL_SCORE": 96,
  "NEXT_STEPS": ["Commit changes"]
}
```
