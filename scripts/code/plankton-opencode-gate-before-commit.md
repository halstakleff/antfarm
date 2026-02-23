---
script_id: plankton-opencode-gate-before-commit
version: 1.0.0
sacred_docs: [PROJECT_KB.md]
framework_refs: [framework/plankton-behavior-contract.md]
---

# Script: Plankton OpenCode Gate Before Commit

## Title
Pre-Commit Quality Gate - Block Commit on Failure

## Purpose
Enforce quality standards before allowing commits. Fail fast if S0/S1 violations.

## When to Run
- Git pre-commit hook
- Before `git commit`
- CI/CD quality gate

## Prerequisites
- Plankton setup complete
- Changes staged or unstaged

## Inputs

| Field | Type | Required | Default |
|-------|------|----------|---------|
| staged_only | boolean | No | false |
| severity_threshold | string | No | S1 |
| allow_warnings | boolean | No | true |

## Step-by-Step Execution

### Step 0: Check Prerequisites
```bash
# S0: Gate components exist
if [ ! -x tools/opencode/opencode_with_gates.sh ]; then
  echo "ERROR: Gate wrapper not found"
  exit 1
fi

# S1: Git repo exists
if [ ! -d .git ]; then
  echo "ERROR: Not a git repository"
  exit 1
fi
```

### Step 1: Check for Changes
```bash
if [ "$staged_only" = true ]; then
  CHANGES=$(git diff --cached --name-only)
else
  CHANGES=$(git diff --name-only)
fi

if [ -z "$CHANGES" ]; then
  echo "[STATUS] No changes to validate"
  exit 0
fi

echo "Files to validate:"
echo "$CHANGES"
```

### Step 2: Run Quality Gate
```bash
# Execute gate on current directory
TIMESTAMP=$(date +%Y%m%d-%H%M%S)
GATE_OUT="outputs/quality/pre-commit-$TIMESTAMP"

./tools/quality/gate.sh --output "$GATE_OUT"
GATE_EXIT=$?

# Extract results
if [ -f "$GATE_OUT/quality_report.json" ]; then
  STATUS=$(jq -r '.status' "$GATE_OUT/quality_report.json")
  S0=$(jq -r '.summary.s0' "$GATE_OUT/quality_report.json")
  S1=$(jq -r '.summary.s1' "$GATE_OUT/quality_report.json")
  S2=$(jq -r '.summary.s2' "$GATE_OUT/quality_report.json")
  REC=$(jq -r '.summary.recommendation' "$GATE_OUT/quality_report.json")
else
  echo "ERROR: Gate report not generated"
  exit 1
fi
```

### Step 3: Hard Block Logic

```bash
echo ""
echo "=========================================="
echo "PRE-COMMIT QUALITY GATE"
echo "=========================================="
echo "Status: $STATUS"
echo "S0 (Critical): $S0"
echo "S1 (Errors):   $S1"
echo "S2 (Style):    $S2"
echo "=========================================="
echo ""

# HARD BLOCK: S0 violations
if [ "$S0" -gt 0 ]; then
  echo "❌ COMMIT BLOCKED"
  echo "   Reason: $S0 critical (S0) violations"
  echo "   Recommendation: $REC"
  echo ""
  echo "Fix before committing:"
  jq -r '.violations[] | select(.severity == "S0") | "  - \(.file):\(.line) \(.message)"' \
    "$GATE_OUT/quality_report.json"
  echo ""
  exit 1
fi

# HARD BLOCK: S1 violations (if threshold = S1)
if [ "$severity_threshold" = "S1" ] && [ "$S1" -gt 0 ]; then
  echo "❌ COMMIT BLOCKED"
  echo "   Reason: $S1 errors (S1) violations"
  echo "   Recommendation: $REC"
  echo ""
  echo "Fix before committing:"
  jq -r '.violations[] | select(.severity == "S1") | "  - \(.file):\(.line) \(.message)"' \
    "$GATE_OUT/quality_report.json"
  echo ""
  exit 1
fi
```

### Step 4: Warn on Style

```bash
# WARN: S2 style issues
if [ "$S2" -gt 0 ] && [ "$allow_warnings" = true ]; then
  echo "⚠️  Warning: $S2 style issues (S2)"
  echo "   Auto-fixes may have been applied"
  echo "   Run: git add ."
  echo ""
fi
```

### Step 5: Allow Commit

```bash
# Calculate RL score
if [ "$S0" -eq 0 ] && [ "$S1" -eq 0 ]; then
  RL_SCORE=95
  [ "$S2" -gt 0 ] && RL_SCORE=$((95 - S2))
  [ $RL_SCORE -lt 80 ] && RL_SCORE=80
else
  RL_SCORE=60
fi

echo "✅ COMMIT ALLOWED"
echo "   RL Score: $RL_SCORE"
echo "   Report: $GATE_OUT/quality_report.json"
echo ""

exit 0
```

### Step 6: Update PROJECT_KB.md

```bash
# Log pre-commit gate
echo "
## $(date) - Pre-commit Gate
- Result: $STATUS
- S0: $S0, S1: $S1, S2: $S2
- Commit: $(git rev-parse --short HEAD 2>/dev/null || echo 'N/A')
- RL Score: $RL_SCORE
" |>> PROJECT_KB.md
```

## Verification Commands

```bash
# Test with intentional lint error
echo 'const x = "unterminated' >> test.js
./scripts/code/plankton-opencode-gate-before-commit.md
# Expect: BLOCKED

# Test clean code
rm test.js
./scripts/code/plankton-opencode-gate-before-commit.md
# Expect: ALLOWED

# Verify report exists
ls outputs/quality/pre-commit-*/quality_report.json

# Check PROJECT_KB updated
grep -q "Pre-commit Gate" PROJECT_KB.md
```

## Rollback

```bash
# Remove pre-commit hook
rm -f .git/hooks/pre-commit

# Revert PROJECT_KB
git checkout PROJECT_KB.md
```

## RL Scoring Rubric

| Criterion | Weight | Target |
|-----------|--------|--------|
| Gate executes | 20% | Report exists |
| S0 blocks | 30% | Hard block on >0 |
| S1 blocks | 30% | Hard block on >0 |
| Report valid | 20% | JSON valid |

**Gate PASS**: RL ≥95 (S0=0, S1=0)  
**Gate FAIL**: RL ≤60 (S0>0)  
**Block enforced**: Exit 1

## Installation

```bash
# As git pre-commit hook
cp scripts/code/plankton-opencode-gate-before-commit.md .git/hooks/pre-commit
chmod +x .git/hooks/pre-commit

# Or via husky
npx husky add .husky/pre-commit "./tools/quality/gate.sh --output outputs/quality/pre-commit"
```

## Status Output Format

```json
{
  "STATUS": "BLOCKED|ALLOWED",
  "FILES_MODIFIED": ["PROJECT_KB.md"],
  "COMMANDS_RUN": [
    "tools/quality/gate.sh",
    "jq extraction"
  ],
  "TEST_RESULTS": {
    "gate_status": "pass",
    "s0": 0,
    "s1": 0,
    "commit_allowed": true
  },
  "RL_SCORE": 95,
  "NEXT_STEPS": ["git commit"]
}
```
