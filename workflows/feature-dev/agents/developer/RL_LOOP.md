# Ralph Loop Execution Guide

## Quick Start

```bash
# Run Ralph loop on any task
./ralph-loop.sh "Implement auth module" "JWT,refresh tokens,rate limiting"

# Or use the inline method documented in AGENTS.md:
# 1. Execute task in fresh session
# 2. Calculate RL score
# 3. If RL < 95, loop again
# 4. If RL >= 95, mark STATUS: done
```

## RL Score Calculation

Use the rubric from RL_SCORES.md:

```
Raw Score = Σ (criterion_score × weight)
RL Score = Raw Score as percentage
```

### Example

| Criterion | Score | Weight | Weighted |
|-----------|-------|--------|----------|
| Completeness | 25 | 25% | 6.25 |
| Tests Pass | 20 | 20% | 4.0 |
| Typecheck | 15 | 15% | 2.25 |
| Security | 20 | 20% | 4.0 |
| Performance | 10 | 10% | 1.0 |
| Maintainability | 10 | 10% | 1.0 |
| **TOTAL** | | | **18.5/20 = 92.5%** |

**Round to nearest integer: RL_SCORE: 93**

If < 95, identify which criteria failed and fix in next iteration.

## Mandatory Output

Every iteration must report:

```
RALPH_ITERATION: N
RL_SCORE: XX
STATUS: done|loop
EVIDENCE: What was accomplished
FAILED_CRITERIA: List if any
```

## Loop Termination

- **Success**: RL_SCORE >= 95 → STATUS: done
- **Failure**: Max iterations (5) reached, RL < 95 → Alert human

---
**Remember: Fresh context per iteration. State persists via git + PROJECT_KB.md**
