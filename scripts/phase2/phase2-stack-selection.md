# Phase 2: Stack Selection

## Purpose

Make informed technology decisions with documented trade-offs. Every choice must be justified.

## When to Run

- After requirements finalized
- Before any code written
- When evaluating new tech options
- During architectural reviews

## Prerequisites

- Functional requirements complete
- Performance invariants defined
- Team skill assessment
- Budget constraints understood

## Inputs

```yaml
performance_requirements: [latency, throughput needs]
scalability_targets: [user count, data volume]
teammate_expertise: [known languages/frameworks]
integration_needs: [external systems]
budget: [licensing, hosting costs]
```

## Outputs

```
STATUS: done
STACK_DECISIONS: /path/to/STACK_DECISIONS.md
TECH_RATIONALE: /path/to/TECH_RATIONALE.md
TRADE_OFF_LOG: /path/to/TRADE_OFFS.md
RL_SCORE: [0-100]
```

## Step-by-Step Execution

### Step 1: Candidate Identification

```bash
opencode run --agent "identify 3 candidates per layer: languages, frameworks, databases, message queues, cloud providers" --file stack/candidates.md
```

### Step 2: Evaluation Matrix

```bash
opencode run --agent "create evaluation matrix: criteria (performance, scalability, ecosystem, expertise, cost) with weights" --file stack/evaluation-matrix.md
```

### Step 3: Trade-Off Analysis

```bash
opencode run --agent "document trade-offs for final choices: what we're gaining and losing" --file stack/trade-offs.md
opencode run --agent "define migration path if decision changes later" --file stack/migration-path.md
```

## Ralph Loop

```bash
ITERATION=0; MAX=5; THRESH=95
while [ $ITERATION -lt $MAX ]; do
    ITERATION=$((ITERATION + 1))
    LAYERS=$(grep -c "## " STACK_DECISIONS.md 2>/dev/null || echo "0")
    RATIONALE=$(grep -c "### Rationale" TECH_RATIONALE.md 2>/dev/null || echo "0")
    RL_SCORE=$((LAYERS * 15 + RATIONALE * 10))
    [ $RL_SCORE -gt 100 ] && RL_SCORE=100
    if [ $RL_SCORE -ge $THRESH ]; then echo "STATUS: done"; exit 0; fi
done
```

## RL Scoring

| Criteria | Weight |
|----------|--------|
| Coverage | 25% |
| Trade-offs | 25% |
| Expertise | 20% |
| Performance | 20% |
| Cost | 10% |

## Verification

```bash
for layer in frontend backend database cache queue; do
    grep -q "### $layer" STACK_DECISIONS.md && echo "✅ $layer selected" || echo "❌ $layer missing"
done
```

## Status Output

```
STATUS: done
FILES_MODIFIED:
  - stack/candidates.md
  - stack/evaluation-matrix.md
  - stack/trade-offs.md
  - STACK_DECISIONS.md
RL_SCORE: 95
NEXT_STEPS: Phase 2b - Data Model
```
