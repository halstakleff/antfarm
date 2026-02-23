# Tiered Reliability Engine v4.2
## Token-Optimized + Auto-Strict + Cost-Aware

**Purpose**: Reduce hallucinations, retry loops, unnecessary tool calls, and verbose outputs while increasing deterministic quality.

**Core Principle**: Automatically scale verification to risk. No manual mode selection required.

---

## LAYER 1: FAST MODE (DEFAULT)

### When Active
- 100% of tasks by default
- Until STRICT triggers detected

### Use Cases
- Brainstorming
- Messaging drafts
- Outlines
- Strategy discussions
- Ideation
- Quick lookups
- Status checks

### Rules
| Aspect | Requirement |
|--------|-------------|
| Verification | V1 (internal consistency only) |
| Artifacts | NONE |
| Evidence blocks | NONE in output |
| Structured contract | NONE in visible output |
| Assumptions | Material only, labeled inline |
| Output | Concise, token-efficient |
| RL Score Target | ≥85 |

### Output Format
```
[Fast analysis]

Key points:
- Point 1
- Point 2

Assumptions: [critical only]
```

---

## LAYER 2: STRICT MODE (AUTO-TRIGGERED)

### When Active
Triggered automatically when ANY match found:

**KEYWORD TRIGGERS**
```
edit, modify, refactor, fix, patch, run, install, deploy, release,
workflow, yaml, antfarm, opencode, git commit, push, merge, migrate,
schema, database, auth, rbac, secrets, production, staging, lint,
tests, build, paths, bootstrap, directory, security, vulnerability
```

**FILE TRIGGERS**
```
- workflows/**/*.yml
- agents/**/*bootstrap*, agents/**/*instructions*
- tools/**/**
- scripts/**/*.md
- package.json
- tsconfig.*
- next.config.*
- **/migration*/**
- .env.example
- infra/**, deployment/**
- Dockerfile*, docker-compose*
- .github/workflows/**
```

**RISK OVERRIDES** (Always STRICT)
- Production environment
- Authentication/authorization changes
- Database schema changes
- Security-related changes
- Breaking API changes
- Rollback-critical paths

### Use Cases
- Code/workflow edits
- Configuration changes
- Tool installations
- Deployments
- Security-relevant tasks
- Infrastructure changes

### Rules
| Aspect | Requirement |
|--------|-------------|
| Verification | V2 minimum, V3 for code/config |
| Artifacts | REQUIRED in outputs/verification/|
| Evidence blocks | Summary only, link to artifact |
| Structured contract | REQUIRED in artifact |
| Assumptions | ALL documented with severity |
| Output | Evidence summary + artifact path |
| RL Score Target | ≥95 |

### Blocking Conditions
- STRICT task without required verification level → BLOCK
- STRICT task without artifact → BLOCK
- S0 severity → Always BLOCK
- S1 severity → BLOCK until resolved
- V3 required but only V2 provided → BLOCK

### Output Format
```
[Evidence summary - 3 lines max]

Verification: V3 ✓
Severity: S2
Confidence: HIGH
Artifact: outputs/verification/TIMESTAMP/report.json

Rollback: [command]
```

---

## LAYER 3: COST-AWARE MODE (ALWAYS ON)

### Global Rules
| Rule | Implementation |
|------|----------------|
| No redundant tool calls | Cache file hashes in PROJECT_KB.md |
| Verify only changed paths | Hash comparison before tool run |
| Avoid repeating context | Reference previous outputs via artifact path |
| Avoid redundant explanations | "See [artifact] for full details" |
| Prefer structured JSON | When chaining agents |
| Summarize long outputs | >20 lines → summary + link |
| Optimize for correctness/token | Quality per token metric |

### Hash Caching
```
PROJECT_KB.md format:
- file_hash: sha256:/path/to/file = abc123...
- verified_at: timestamp
- verification_level: V1|V2|V3
```

### Skip Conditions
- File hash unchanged → Skip verification
- No triggers detected → FAST mode
- Previous V3 + no changes → Reference prior artifact

---

## VERIFICATION LEVELS

| Level | Description | When Used |
|-------|-------------|-----------|
| V0 | None | Emergency overrides only |
| V1 | Internal consistency | FAST mode |
| V2 | External validation | STRICT mode (docs, strategies) |
| V3 | Full verification | STRICT mode (code, config, workflows) |

---

## SEVERITY CLASSIFICATION

| Severity | Meaning | Action |
|----------|---------|--------|
| S0 | Critical failure | BLOCK, require immediate fix |
| S1 | Error, blocking | BLOCK until resolved |
| S2 | Warning, non-blocking | LOG, address in next cycle |
| S3 | Info, observability | LOG only |

---

## CONFIDENCE SCORING

| Level | Threshold | Meaning |
|-------|-----------|---------|
| HIGH | ≥95% | Verified, tested, canonical |
| MED | 75-94% | Partial verification, some assumptions |
| LOW | <75% | High uncertainty, requires review |

---

## RL SCORE MODIFIERS

| Condition | Modifier |
|-----------|----------|
| V3 verification | +10 |
| V2 verification | +5 |
| Artifact generated | +5 |
| Hash cache hit (cost-aware) | +3 |
| S0/S1 found | -20 |
| Missing required verification | -15 |
| Missing artifact (STRICT) | -15 |
| Redundant tool call | -5 |

Target: FAST ≥85, STRICT ≥95

---

## AGENT CONTRACT

### Strict Mode Handoff
```yaml
from: master_orchestrator
to: verification_agent
task: "Verify [description]"
mode: STRICT
required_v_level: V2|V3
triggers:
  keywords: [...]
  files: [...]
artifacts:
  - outputs/verification/TIMESTAMP/report.json
stop_conditions:
  - S0 detected
  - V level not met
  - confidence < MED
```

### Verification Agent Output
```yaml
status: PASS|FAIL|BLOCK
mode: STRICT
verification_level: V0|V1|V2|V3
severity: S0|S1|S2|S3
confidence: HIGH|MED|LOW
artifact: /path/to/report.json
blocking_reason: "..." # if BLOCK
rl_modifier: -5 # applied to score
```

---

## COST METRICS

Track per task:
- Tokens used
- Tools called
- Time elapsed
- RL score achieved
- Verification level applied

Target: Reduce tokens/task by 40% while maintaining ≥95 STRICT quality.

---

## IMPLEMENTATION CHECKLIST

- [x] Framework documented
- [ ] Auto-trigger spec
- [ ] Verification gate script
- [ ] Verification skill
- [ ] Verifier agent (optional)
- [ ] Workflow integration
- [ ] Token enforcement active
- [ ] Proof tests pass

**Version**: 4.2  
**Last Updated**: 2026-02-22
