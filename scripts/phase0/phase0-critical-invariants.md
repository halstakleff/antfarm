# Phase 0: Critical Invariants

## Purpose

Define the non-negotiable boundaries that must never be violated during the build. These are the guardrails that protect against scope creep, technical debt, and misalignment.

## When to Run

- After risk mapping
- Before any architectural decisions
- When scoping iterations
- During sprint planning

## Prerequisites

- PRODUCT_THESIS.md
- RISK_REGISTER.md
- CONSTRAINTS.md
- Stakeholder sign-off on boundaries

## Inputs

```yaml
business_invariants: [never-break business rules]
technical_invariants: [architectural non-negotiables]
performance_invariants: [latency, throughput minimums]
security_invariants: [mandatory security checks]
data_invariants: [integrity, retention, privacy]
```

## Outputs

```
STATUS: done
INVARIANTS: /path/to/INVARIANTS.md
INVARIANT_TESTS: /path/to/tests/invariants/
VIOLATION_RESPONSE: /path/to/VIOLATION_RESPONSE.md
RL_SCORE: [0-100]
```

## Step-by-Step Execution

### Step 1: Invariant Discovery

```bash
# Extract invariants from thesis and constraints
opencode run --agent "extract specific invariants from PRODUCT_THESIS and CONSTRAINTS: what must ALWAYS be true, what must NEVER happen" --file INVARIANTS.md

# Categorize invariants
opencode run --agent "categorize invariants by: business, technical, security, performance, data" --file INVARIANTS.md
```

### Step 2: Invariant Test Definition

```bash
# Define automated invariant checks
opencode run --agent "for each invariant, write a test that would fail if invariant is violated" --file tests/invariants/invariant-tests.md

# Create continuous monitoring
opencode run --agent "create infrastructure monitoring checks for runtime invariants" --file tests/invariants/monitoring.md
```

### Step 3: Violation Response Plan

```bash
# Define escalation procedures
opencode run --agent "for violation of each invariant S0/S1/S2 level, define: who to notify, stop conditions, rollback plan" --file VIOLATION_RESPONSE.md
```

## Ralph Loop

```bash
ITERATION=0; MAX_ITERS=5; THRESHOLD=95

while [ $ITERATION -lt $MAX_ITERS ]; do
    ITERATION=$((ITERATION + 1))
    
    INVARIANT_COUNT=$(grep -c "### Invariant" INVARIANTS.md 2>/dev/null || echo "0")
    TEST_COUNT=$(ls tests/invariants/ 2>/dev/null | wc -l)
    
    RL_SCORE=$(( (INVARIANT_COUNT * 50 + TEST_COUNT * 50) / 10 ))
    [ $RL_SCORE -gt 100 ] && RL_SCORE=100
    
    if [ $RL_SCORE -ge $THRESHOLD ]; then
        echo "STATUS: done"; echo "RL_SCORE: $RL_SCORE" >> PROJECT_KB.md
        exit 0
    fi
    
    echo "Looping..."
done

echo "STATUS: failed"; exit 1
```

## RL Scoring

| Criteria | Weight |
|----------|--------|
| Completeness | 35% |
| Test Coverage | 35% |
| Measurable | 20% |
| Enforcible | 10% |

## Verification

```bash
grep -c "### Invariant" INVARIANTS.md
ls tests/invariants/ | wc -l
grep -q "Violation Response" VIOLATION_RESPONSE.md
```

## Status Output

```
STATUS: done
FILES_MODIFIED:
  - INVARIANTS.md
  - tests/invariants/
  - VIOLATION_RESPONSE.md
RL_SCORE: 97
NEXT_STEPS: Phase 1 Requirements
```
