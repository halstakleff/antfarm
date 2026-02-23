# Plankton Behavior Contract (OpenCode Adaptation)

**Source**: https://github.com/alexfazio/plankton  
**License**: MIT (reference only, behavior abstraction)  
**Version**: 1.0.0

---

## Behavior Summary

Plankton is write-time code quality enforcement for AI coding agents. The agent is blocked from proceeding until its output passes quality checks.

---

## Trigger Points (OpenCode Adaptation)

| Plankton | OpenCode Equivalent |
|----------|---------------------|
| `.claude/hooks/` | `tools/opencode/opencode_with_gates.sh` |
| PreToolUse hook | Post-execution gate check |
| Auto-activation | Explicit --agent gate enforcement |
| Run-from-directory | Callable from any workflow |

---

## Three-Phase Execution Model

### Phase 1: Auto-Format (Silent Fixes)
| Tool | Language | Auto-Fix? |
|------|----------|-----------|
| ruff | Python | ✅ |
| biome | TypeScript/JavaScript | ✅ |
| shfmt | Shell | ✅ |
| taplo | TOML | ✅ |
| markdownlint | Markdown | ✅ |
| prettier | JS/TS/CSS/HTML | ✅ |

**Behavior**: Run first, apply fixes silently, re-stage changes.

### Phase 2: Lint Collection (Violation Detection)
| Tool | Purpose | Severity |
|------|---------|----------|
| ruff check | Python linting | S1-S2 |
| biome lint | TS/JS correctness | S1 |
| eslint | TS/JS patterns | S1-S2 |
| tsc | TypeScript types | S0 |
| pyright | Python types | S0 |
| vulture | Dead code | S2 |
| knip | TS/JS dead code | S2 |
| bandit | Python security | S1 |
| semgrep | Multi-lang security | S1 |
| shellcheck | Shell correctness | S1 |
| hadolint | Dockerfile | S1 |
| yamllint | YAML validation | S2 |
| jscpd | Duplicate detection | S2 |

**Behavior**: Collect violations as structured JSON, no auto-fix.

### Phase 3: Remediation (Ralph Loop)
| Behavior | Implementation |
|----------|----------------|
| Delegate to Claude | Ralph loop remediation |
| Reason about each fix | Iterative RL scoring |
| Apply fixes | Re-run gates until pass |

---

## Severity Mapping

| Severity | Meaning | Action | Tools |
|----------|---------|--------|-------|
| **S0** | Build/Test/Type/Security failure | **BLOCK** - Exit 1, stop workflow | tsc, pyright, pytest, security scans |
| **S1** | Lint error (correctness issue) | **BLOCK** - Must fix before proceed | ruff check, eslint --no-fix, biome lint |
| **S2** | Style/Format drift | **AUTO-FIX** - Fix in Phase 1 | prettier, ruff format, shfmt |
| **S3** | Warning (backlog) | **LOG** - Warning only, no block | complexity, duplicate code |

---

## Block-Until-Fixed Logic

```
1. Run Phase 1 (Auto-format)
2. If Phase 1 made changes → Git add, re-run Phase 1
3. Run Phase 2 (Lint collection)
4. Count violations by severity
5. If S0/S1 > 0:
   - Generate remediation task
   - Trigger Ralph loop
   - Fix → Re-run from Phase 1
6. If Phase 3 applied fixes → Re-run from Phase 1
7. Loop until: S0/S1 = 0, S2/S3 optional
8. Exit 0, allow commit
```

---

## Configuration

| Config Key | Default | Description |
|------------|---------|-------------|
| `exclusions` | `["tests/", "vendor/"]` | Paths to skip |
| `languages` | `auto-detect` | Enabled languages |
| `severity_threshold` | `S1` | Max allowed severity |
| `autofix_enabled` | `true` | Run Phase 1 |
| `remediation_enabled` | `true` | Run Phase 3 (Ralph) |

---

## Report Format

```json
{
  "status": "pass|fail",
  "stack_detected": ["ts", "python", "shell"],
  "autofixes_applied": [
    {"tool": "biome", "files": ["src/main.ts"], "changes": 3}
  ],
  "violations": [
    {
      "severity": "S0",
      "tool": "tsc",
      "file": "src/main.ts",
      "rule": "TS2345",
      "message": "Argument of type 'X' is not assignable to 'Y'",
      "line": 42,
      "column": 15
    }
  ],
  "summary": {
    "s0": 1,
    "s1": 0,
    "s2": 3,
    "s3": 5,
    "files_changed": 2,
    "recommendation": "Fix TS2345 type error before proceeding"
  },
  "commands_run": [
    "biome format --write",
    "tsc --noEmit",
    "eslint ."
  ],
  "timings_ms": {
    "phase1": 1245,
    "phase2": 3421,
    "phase3": 0
  }
}
```

---

## OpenCode Adaptation Notes

1. **No Claude Code hooks**: Use `opencode_with_gates.sh` wrapper
2. **Run-from-directory**: Any OpenCode workflow can invoke
3. **PreToolUse**: Implement as post-execution gate
4. **Config tamper-proof**: Store in framework/, protect with git

---

## RL Scoring Integration

| Gate Result | RL Score | Action |
|-------------|----------|--------|
| S0 violations | 0-60 | Block, require Ralph loop |
| S1 violations | 61-79 | Block, Ralph loop |
| S2 only | 80-94 | Pass with warnings |
| Clean pass | 95-100 | Proceed |

---

## Sacred Documents

- **PROJECT_KB.md**: Log quality gate results
- **quality_report.json**: Structured artifacts in `outputs/quality/`
