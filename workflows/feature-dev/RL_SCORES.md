# Microsoft RL Scoring Rubric

_Applied by ALL agents during verification and selection_

---

## Scoring Matrix

### Implementation Tasks

| Criteria | Weight | Scoring Guide |
|----------|--------|---------------|
| **Completeness** | 25% | 0=missing, 15=partial, 25=full |
| **Tests Pass** | 20% | 0=none, 10=partial, 20=all pass |
| **Typecheck** | 15% | 0=errors, 15=pass |
| **Security** | 20% | 0=issues, 10=minor, 20=clean |
| **Performance** | 10% | 0=regression, 10=baseline, 15=improved |
| **Maintainability** | 10% | 0=horrible, 10=clean code |

**Threshold for STATUS: done = 95 points (95%)**

### Design Tasks (Architect)

| Criteria | Weight | Scoring Guide |
|----------|--------|---------------|
| **Completeness** | 30% | Stories cover all requirements |
| **Simplicity** | 25% | Simple > clever |
| **Dependencies** | 20% | Clear ordering, minimal coupling |
| **Verifiability** | 15% | Clear acceptance criteria |
| **Risk Flags** | 10% | Unknowns identified |

**Threshold for STATUS: designed = 95 points (95%)**

### Research Tasks

| Criteria | Weight | Scoring Guide |
|----------|--------|---------------|
| **Coverage** | 30% | All key areas explored |
| **Pattern Discovery** | 25% | Reusable patterns found |
| **Dependency Map** | 25% | Clear dependency list |
| **Risk Identification** | 20% | Unknowns/risks flagged |

**Threshold for STATUS: researched = 90 points (90%)**

### Debug/Optimize Tasks

| Criteria | Weight | Scoring Guide |
|----------|--------|---------------|
| **Root Cause** | 30% | Actually found, not symptom |
| **Fix Options** | 20% | Multiple considered |
| **Trade-off Clarity** | 25% | Pros/cons documented |
| **Recommendation** | 15% | Best option selected |
| **Fix Validation** | 10% | Fix actually works |

**Threshold for STATUS: analyzed = 90 points (90%)**

---

## Calculation

```
Raw Score = Σ (category_score × weight)
RL Score = Raw Score (as percentage)
```

---

## Usage

All agents must calculate and report RL Score in their output:

```
RL_SCORE: 97
```

_If RL_SCORE < threshold, loop continues_
