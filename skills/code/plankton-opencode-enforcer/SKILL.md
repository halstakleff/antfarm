---
skill_name: plankton-opencode-enforcer
version: 1.0.0
required_tools: [opencode CLI, git, jq]
input_schema:
  task: string
  directory: string
  max_retries: number
  severity_threshold: string
output_schema:
  status: string
  s0_count: number
  s1_count: number
  s2_count: number
  s3_count: number
  files_changed: number
  quality_report_path: string
  remediation_task_path: string|null
  rl_score: number
  confidence: number
side_effects: [file_changes, git_staging, quality_report_generation]
minimal_self_test_command: tools/opencode/opencode_with_gates.sh --help
---

# Skill: Plankton OpenCode Enforcer

## Purpose
Write-time code quality enforcement for OpenCode CLI. Replicates Plankton's behavior: block until quality passes, auto-fix where possible, structured reporting.

## Behavior Contract

### Trigger Points
- Post-edit gate execution
- Mandatory before commit
- Auto-fix in Phase 1
- Block on S0/S1 violations

### Three-Phase Execution
1. **FORMAT**: Auto-fix with biome, prettier, ruff, black
2. **LINT**: Collect violations (no auto-fix)
3. **REMEDIATE**: Ralph loop fixes remaining issues

### Severity Mapping
| Level | Meaning | Action |
|-------|---------|--------|
| S0 | Build/Test/Type/Security | BLOCK - Exit 1 |
| S1 | Lint errors | BLOCK - Fix required |
| S2 | Style/Format | Auto-fix |
| S3 | Warnings | Log only |

## Input Schema

```yaml
task: "Fix type error in auth module"
directory: "./src"
max_retries: 3
severity_threshold: "S1"
```

## Output Schema

```json
{
  "analysis": "Quality gate passed after 1 remediation",
  "structured_output": {
    "status": "pass",
    "s0_count": 0,
    "s1_count": 0,
    "s2_count": 2,
    "s3_count": 3,
    "files_changed": 1,
    "quality_report_path": "outputs/quality/20260223-120000/quality_report.json",
    "remediation_task_path": null,
    "rl_score": 96
  },
  "confidence": 0.98
}
```

## Usage

```bash
# Via OpenCode CLI
opencode run --agent "plankton-opencode-enforcer" \
  --task "implement feature" \
  --directory "./src"

# Via wrapper directly
./tools/opencode/opencode_with_gates.sh \
  --agent build \
  --directory ./ \
  -- "your task here"
```

## Ralph Loop Integration

```yaml
rl_threshold: 95
checks:
  - s0_count == 0
  - s1_count == 0
  - quality_report_exists
severity_action:
  S0: block_and_remediate
  S1: block_and_remediate
  S2: autocorrect
  S3: log_only
```

## RL Scoring

| Criterion | Weight | Threshold |
|-----------|--------|-----------|
| Gate PASS | 40% | Pass |
| S0 = 0 | 25% | Must be 0 |
| S1 = 0 | 25% | Must be 0 |
| Report valid | 10% | JSON valid |

**Gate FAIL**: RL_SCORE ≤ 80 (triggers Ralph loop)  
**Gate PASS**: RL_SCORE ≥ 95 (proceed)

## Error Recovery

| Error | Action |
|-------|--------|
| Max retries exceeded | Exit 1, manual intervention |
| No stack detected | Skip to docs/yaml checks |
| Tool not found | Graceful skip, warning logged |

## Sacred Documents

- **PROJECT_KB.md**: Log gate results, track quality trends
- **outputs/quality/<timestamp>/quality_report.json**: Structured report
- **outputs/quality/<timestamp>/remediation_<n>.md**: Remediation tasks

## Dependencies

- `opencode` CLI installed
- Git repository initialized
- jq for JSON processing

## Stack Detection

Auto-detects by file presence:
- `package.json` → JavaScript/Node.js
- `tsconfig.json` → TypeScript
- `next.config.*` → Next.js
- `pyproject.toml` → Python
- `Cargo.toml` → Rust
- `go.mod` → Go
- `Dockerfile` → Docker
- `*.md` → Markdown docs
- `*.yml`/`*.yaml` → YAML files
