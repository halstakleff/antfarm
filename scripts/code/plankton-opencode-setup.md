---
script_id: plankton-opencode-setup
version: 1.0.0
sacred_docs: [PROJECT_KB.md]
framework_refs: [framework/plankton-behavior-contract.md]
---

# Script: Plankton OpenCode Setup

## Title
Plankton for OpenCode - Initial Setup

## Purpose
Install and configure Plankton-style quality gates for OpenCode workflows.

## When to Run
- First time setup
- New project onboarding
- After stack changes

## Prerequisites
- Git repository initialized
- OpenCode CLI installed
- Python/Node.js tools available

## Inputs

| Field | Type | Required | Default |
|-------|------|----------|---------|
| project_root | string | No | . |
| install_tools | boolean | No | false |
| severity_threshold | string | No | S1 |

## Step-by-Step Execution

### Step 0: Validation (S0-S3)
```bash
# S0: Check git repo exists
if [ ! -d .git ]; then
  echo '{"error":"Not a git repository"}' >2
  exit 1
fi

# S1: Check opencode available
if ! command -v opencode >/dev/null 2>&1; then
  echo '{"error":"opencode not installed"}' >2
  exit 1
fi

echo "[STATUS] Prerequisites OK"
```

### Step 1: Detect Project Stack
```bash
# Run stack detection
./tools/quality/gate.sh --output outputs/quality/setup

# Extract detected stack
STACK=$(jq -r '.stack_detected[]' outputs/quality/setup/quality_report.json | tr '\n' ' ')
echo "Detected stack: $STACK"
```

### Step 2: Create Quality Config
```bash
cat > .plankton-config.json << 'EOF'
{
  "version": "1.0.0",
  "severity_threshold": "S1",
  "exclusions": ["tests/", "vendor/", "node_modules/", ".git/"],
  "phases": {
    "format": { "enabled": true, "autofix": true },
    "lint": { "enabled": true },
    "typecheck": { "enabled": true },
    "tests": { "enabled": true },
    "security": { "enabled": true },
    "docs": { "enabled": true }
  },
  "max_retries": 3
}
EOF

echo "[STATUS] Config created: .plankton-config.json"
```

### Step 3: Install Required Tools (Optional)
```bash
# Only if install_tools=true
if [ "$install_tools" = true ]; then
  # JavaScript/TypeScript
  if [ -f package.json ]; then
    npm install --save-dev @biomejs/biome prettier eslint
  fi
  
  # Python
  if [ -f pyproject.toml ]; then
    pip install ruff black mypy bandit
  fi
  
  echo "[STATUS] Tools installed"
fi
```

### Step 4: Verify Setup
```bash
# Test the gate runner
if ./tools/opencode/opencode_with_gates.sh --help >/dev/null 2>&1; then
  echo "[STATUS] Wrapper functional"
else
  echo "[ERROR] Wrapper failed"
  exit 1
fi

echo "[STATUS] Setup complete"
```

### Step 5: Update PROJECT_KB.md
```bash
echo "
## $(date) - Plankton Setup Complete
- Stack detected: $STACK
- Severity threshold: S1
- Max retries: 3
- Config: .plankton-config.json
" |>> PROJECT_KB.md
```

## Verification Commands

```bash
# Verify config exists
test -f .plankton-config.json

# Verify wrapper executable
test -x tools/opencode/opencode_with_gates.sh

# Test help output
./tools/opencode/opencode_with_gates.sh --help | grep -q "Usage"

# Verify stack detection
./tools/quality/gate.sh --output /tmp/test_gate 2>&1 | head -5

# Check PROJECT_KB.md updated
grep -q "Plankton Setup" PROJECT_KB.md
```

## Rollback

```bash
# Remove config
rm -f .plankton-config.json

# Revert PROJECT_KB.md
git checkout PROJECT_KB.md
```

## RL Scoring Rubric

| Criterion | Weight | Target |
|-----------|--------|--------|
| Setup success | 30% | Config created |
| Stack detected | 20% | >= 1 stack |
| Wrapper functional | 25% | Help works |
| PROJECT_KB updated | 15% | Entry added |
| Token efficiency | 10% | < 1000 |

**Threshold**: ≥95

## Status Output Format

```json
{
  "STATUS": "COMPLETE",
  "FILES_MODIFIED": [".plankton-config.json", "PROJECT_KB.md"],
  "COMMANDS_RUN": [
    "tools/quality/gate.sh",
    "cat \u003e .plankton-config.json"
  ],
  "TEST_RESULTS": {
    "stack_detected": ["ts", "next"],
    "config_valid": true,
    "wrapper_ok": true
  },
  "RL_SCORE": 97,
  "NEXT_STEPS": ["Run plankton-opencode-run.md"]
}
```
