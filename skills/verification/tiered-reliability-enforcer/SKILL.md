---
skill_name: tiered-reliability-enforcer
version: 4.2.0
required_tools: [bash, sha256sum, grep, jq]
input_schema:
  task_text: string
  files_changed: array
  force_mode: string|null
  skip_cache: boolean
output_schema:
  mode: string
  verification_level: string
  severity: string
  confidence: string
  artifact_path: string|null
  rl_modifier: number
  status: string
side_effects:
  - artifact_generation
  - hash_cache_update
  - PROJECT_KB.md_write
minimal_self_test_command: "echo '{\"task_text\":\"test\"}' | bash scripts/verification/tiered-verification-gate.md"
---

# Skill: Tiered Reliability Enforcer

## Purpose
Automatically enforce tiered reliability standards (FAST vs STRICT) with automatic mode detection, hash caching, and RL-scored verification.

## Behavior

### Automatic Mode Detection
| Input | Mode | V-Level |
|-------|------|---------|
| Brainstorm, draft, lookup | FAST | V1 |
| "edit", "workflow", "deploy" | STRICT | V3 |
| File in workflows/, agents/, tools/ | STRICT | V3 |
| package.json, tsconfig, Dockerfile | STRICT | V3 |
| Database, auth, security keywords | STRICT | V3 |

### Cost-Aware Optimization
- Hash cache in PROJECT_KB.md prevents redundant checks
- Skip verification if file hash unchanged
- Reference prior V-level on cache hit
- Update hash after verification

### Ralph Loop Integration

```yaml
rl_threshold:
  FAST: 85
  STRICT: 95

triggers:
  - S0 severity: immediate Ralph loop
  - S1 severity: Ralph loop with remediation task
  - V-level mismatch: Ralph loop with specific fix

remediation_output:
  - outputs/verification/TIMESTAMP/remediation.md
  - Status: BLOCK/FAIL with fix instructions
```

## Input Schema

```yaml
task_text: "Edit the workflow file to add a new step"
files_changed:
  - "workflows/feature-dev/workflow.yml"
force_mode: null        # Optional: FAST, STRICT
skip_cache: false       # Optional: skip hash cache
```

## Output Schema

```json
{
  "analysis": "STRICT mode triggered by keyword 'edit' and file 'workflows/feature-dev/workflow.yml'",
  "structured_output": {
    "mode": "STRICT",
    "verification_level": "V3",
    "severity": "S3",
    "confidence": "HIGH",
    "artifact_path": "outputs/verification/20260223-120000/report.json",
    "rl_modifier": 15,
    "status": "PASS",
    "cache_hit": false
  },
  "confidence": 0.95
}
```

## Usage

```bash
# Via script (direct)
bash scripts/verification/tiered-verification-gate.md \
  "Edit workflow" \
  "workflows/feature.yml"

# Via skill wrapper
opencode run --agent tiered-reliability-enforcer \
  --task_text "Edit workflow" \
  --files_changed '["workflows/feature.yml"]'
```

## Safety Constraints

| Constraint | Enforcement |
|------------|-------------|
| V3 for code changes | Required, blocks if missing |
| Artifact for STRICT | Required, blocks if missing |
| S0 = BLOCK | Hard stop, no override |
| S1 = FAIL | Blocks until resolved |
| Hash cache integrity | Validates before use |
| Secret detection | S0 if found in non-example files |

## Verification Levels

| Level | Description | Output |
|-------|-------------|--------|
| V1 | Internal consistency | Status only |
| V2 | External validation | Artifact + summary |
| V3 | Full verification | Artifact + detailed evidence |

## RL Scoring

| Criterion | Weight | Modifier |
|-----------|--------|----------|
| Correct mode detection | 20% | ±10 |
| Correct V-level | 25% | ±15 |
| Artifact generated (STRICT) | 20% | +5 |
| Severity accurate | 15% | ±10 |
| Hash cache working | 10% | +3 |
| Token efficiency | 10% | Variable |

**FAST Target**: ≥85  
**STRICT Target**: ≥95

## Error Handling

| Error | Action |
|-------|--------|
| Missing task_text | Exit 1, S0 |
| Missing spec file | Exit 1, S0 |
| Hash cache corrupt | Regenerate, S2 warning |
| Artifact write fail | Retry once, then S1 |
| Secret detected | S0, immediate block |

## Integration Points

### Workflow Integration
```yaml
steps:
  - id: verify
    agent: tiered-reliability-enforcer
    before: implement
    condition: always
    on_fail:
      retry_step: implement
      max_retries: 3
```

### Agent Contract
```yaml
input_required:
  - task_text: string
  - files_changed: string[]

output_produced:
  - artifact: outputs/verification/TIMESTAMP/report.json
  - status: PASS|FAIL|BLOCK
  - rl_modifier: number

artifacts_updated:
  - PROJECT_KB.md (hash cache)

failure_modes:
  - S0: Immediate block, Ralph loop
  - S1: Block until resolved
  - Artifact missing: Block (STRICT only)

stop_conditions:
  - S0 detected
  - V3 required but not met
  - Artifact write failure
```

## Cache Format

```
PROJECT_KB.md entry:
file_hash: sha256:/path/to/file = abc123...
verified_at: 2026-02-23T12:00:00Z
verification_level: V3
```

## Minimal Test

```bash
# FAST mode test
result=$(bash scripts/verification/tiered-verification-gate.md \
  "Brainstorm ideas" "")
echo "$result" | grep -q "FAST"
[ $? -eq 0 ] && echo "PASS: FAST detection"

# STRICT mode test
result=$(bash scripts/verification/tiered-verification-gate.md \
  "Edit workflow" "workflows/test.yml")
echo "$result" | grep -q "STRICT"
[ $? -eq 0 ] && echo "PASS: STRICT detection"
```
