# Ralph Loop Skill

MANDATORY iteration wrapper with Microsoft RL scoring gates.

## Philosophy

Every task runs through Ralph loops:
1. Fresh context per iteration
2. State persists via git / PROJECT_KB.md / progress files
3. Loop until completion criteria met
4. Microsoft RL score must be >= 95

## Execution Flow

```
┌─────────────────────────────────────────────────────────────┐
│  PHASE 0: RL Rules Agent (Spawn First)                     │
│  └─→ Creates project-specific scoring rules               │
│  └─→ Defines success/failure criteria                      │
│  └─→ Sets RL reward_weights                                │
└─────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────┐
│  PHASE 1: Work Agent (Spawn with Rules)                    │
│  └─→ Executes task                                         │
│  └─→ Self-checks completion                                │
│  └─→ Reports status + evidence                             │
│  └─→ Calculates RL score                                     │
└─────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────┐
│  PHASE 2: Verification Check                               │
│  ├─→ PASS (RL >= 95): Emit reward, finalize               │
│  ├─→ FAIL: Log failure, spawn correction agent             │
│  └─→ FALSE POSITIVE: Log, respawn work agent              │
└─────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────┐
│  LOOP: Correction → Re-verify → Finalize                   │
└─────────────────────────────────────────────────────────────┘
```

## RL Scoring System

### Default Reward Structure

| Outcome | Points | Trigger |
|---------|--------|---------|
| **Success** | +15 | Task complete, all criteria met |
| **Partial Success** | +5-10 | Mostly complete, minor gaps |
| **False Positive** | 0 | Reported success but verification failed |
| **Failure** | 0 | Task incomplete or broken |
| **Correction Success** | +10 | Fix agent resolves issue |

### Score Calculation

```
Raw Score = Sum of completed criteria
RL Score = (Raw Score / Max Possible) * 100
```

**MANDATORY:** RL Score >= 95 to mark STATUS: done

## Ralph Loop Commands

```bash
# Start Ralph loop
ralph-loop start --task "Implement auth" --criteria "JWT,refresh,rate-limit"

# Check iteration
ralph-loop status

# Complete iteration (triggers RL scoring)
ralph-loop complete --evidence "tests pass, coverage 90%"

# Spawn correction agent
ralph-loop correct --reason "Type error in middleware"
```

## Configuration

```yaml
# .ralph-loop.yml
max_iterations: 5
criteria:
  - "Tests pass"
  - "Typecheck passes"
  - "Security review passed"
  - "Performance baseline met"
rl_threshold: 95
```

## Output Format

```
RALPH_ITERATION: 3
RL_SCORE: 97
STATUS: done
EVIDENCE:
  - tests: 45/45 pass
  - coverage: 92%
  - typecheck: 0 errors
```
