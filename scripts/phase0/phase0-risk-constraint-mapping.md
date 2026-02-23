# Phase 0: Risk & Constraint Mapping

## Purpose

Identify and document all potential risks and constraints before building. This prevents surprises and ensures the team plans mitigations proactively.

## When to Run

- Immediately after Phase 0 (Ideation)
- During architectural reviews
- When external dependencies change
- Before committing to timelines

## Prerequisites

- PRODUCT_THESIS.md complete
- Stakeholder interviews conducted
- Technical architecture draft available
- OpenCode CLI configured

## Inputs

```yaml
project_scope: [defined in Phase 0]
timeline_constraints: [hard vs soft deadlines]
budget_limits: [resource constraints]
technical_environment: [existing systems, integrations]
team_capacity: [skills, availability]
regulatory_requirements: [compliance needs]
```

## Outputs

```
STATUS: done
RISK_REGISTER: /path/to/RISK_REGISTER.md
CONSTRAINT_LIST: /path/to/CONSTRAINTS.md
STOP_CONDITIONS: [S0/S1 triggers defined]
MITIGATION_PLAN: /path/to/MITIGATIONS.md
RL_SCORE: [0-100]
```

## Step-by-Step Execution

### Step 1: Risk Brainstorming Session

```bash
# Use OpenCode to structure risk discovery
opencode run --agent "facilitate risk brainstorm covering: technical, business, operational, security, compliance, team, timeline risks" --file risks/brainstorm-raw.md

# Categorize risks
opencode run --agent "categorize risks by: likelihood (high/medium/low) and impact (critical/significant/minor)" --file risks/risk-categories.md
```

### Step 2: Technical Risk Deep Dive

```bash
# Architecture risk analysis
opencode run --agent "identify technical risks: scalability bottlenecks, tech debt, integration failure, vendor lock-in, skill gaps" --file risks/technical-risks.md

# Security threat modeling
opencode run --agent "conduct STRIDE threat model analysis" --file risks/security-threats.md
```

### Step 3: Constraint Documentation

```bash
# Map constraints
opencode run --agent "document all hard constraints: fixed deadlines, budget caps, regulatory requirements, tech stack mandates" --file CONSTRAINTS.md

# Distinguish hard vs soft constraints
opencode run --agent "label each constraint as: INVARIANT (cannot change) vs NEGOTIABLE (can flex under conditions)" --file CONSTRAINTS.md
```

### Step 4: Stop Conditions Definition

```bash
# Define severity triggers
opencode run --agent "define S0 conditions: data loss, security breach, system downtime, compliance violation" --file STOP_CONDITIONS.md

opencode run --agent "define S1 conditions: feature failure, performance regression, breaking change, user impact" --file STOP_CONDITIONS.md
```

### Step 5: Mitigation Strategy

```bash
# Create mitigation plans
opencode run --agent "for each high-risk item, define: likelihood reduction, impact reduction, contingency plan, owner" --file MITIGATIONS.md

# Risk acceptance criteria
opencode run --agent "define which risks are acceptable, which require executive sign-off, which are showstoppers" --file risk-acceptance.md
```

### Step 6: Sacred Document Updates

```bash
# Update PROJECT_KB.md
echo "## Phase 0b: Risk Mapping Complete
- High Risks: [count]
- Critical Constraints: [count]
- S0 Stop Conditions: [count defined]
- S1 Stop Conditions: [count defined]" >> PROJECT_KB.md

# Update RL_SCORES.md with risk weightings
echo "## Risk Score Weightings
- Technical complexity: 30%
- Dependency count: 25%
- Resource availability: 20%
- Timeline pressure: 15%
- Unknown unknowns: 10%" >> RL_SCORES.md
```

## Ralph Loop Wrapper

```bash
#!/bin/bash
ITERATION=0
MAX_ITERATIONS=5
RL_THRESHOLD=95

while [ $ITERATION -lt $MAX_ITERATIONS ]; do
    ITERATION=$((ITERATION + 1))
    echo "=== Risk Mapping Iteration $ITERATION ==="
    
    # Execute risk mapping
    ./execute-risk-mapping.sh
    
    # Calculate RL score
    HIGH_RISKS=$(grep -c "## High" RISK_REGISTER.md 2>/dev/null || echo "0")
    MITIGATIONS=$(grep -c "### Mitigation" MITIGATIONS.md 2>/dev/null || echo "0")
    CONSTRAINTS=$(grep -c "### Constraint" CONSTRAINTS.md 2>/dev/null || echo "0")
    
    # Weight and score
    RL_SCORE=$(( (HIGH_RISKS * 20 + MITIGATIONS * 35 + CONSTRAINTS * 45) / 10 ))
    
    if [ $RL_SCORE -gt 100 ]; then RL_SCORE=100; fi
    if [ $RL_SCORE -lt 0 ]; then RL_SCORE=0; fi
    
    echo "RL_SCORE: $RL_SCORE"
    echo "STATUS: iteration $ITERATION complete" >> PROJECT_KB.md
    
    if [ $RL_SCORE -ge $RL_THRESHOLD ]; then
        echo "STATUS: done" >> PROJECT_KB.md
        echo "RL_SCORE: $RL_SCORE" >> PROJECT_KB.md
        exit 0
    fi
    
    echo "🔁 Identifying additional risks..."
done

echo "STATUS: max_iterations_reached" >> PROJECT_KB.md
exit 1
```

## Microsoft RL Scoring Rubric

| Criteria | Weight | Thresholds |
|----------|--------|------------|
| **Risk Coverage** | 30% | All major risk categories addressed |
| **Mitigation Plans** | 25% | Every high/critical risk has mitigation |
| **Constraint Clarity** | 25% | Hard vs soft constraints distinguished |
| **Stop Conditions** | 15% | S0/S1 triggers explicitly defined |
| **Ownership Assigned** | 5% | Each risk has assigned owner |

**Thresholds:**
- **95+**: Proceed to Phase 1
- 90-94: Address gaps in mitigations
- 80-89: Incomplete risk categories
- <80: Major gaps - restart Phase 0

## Severity Enforcement Rules

- **S0:** Critical risk with no mitigation plan → STOP
- **S0:** Unrecognized constraint causes scope violation → STOP
- **S1:** Risk owner not assigned → FIX IMMEDIATELY
- **S1:** Mitigation plan not actionable → REWRITE
- **S2:** Risk likelihood misjudged → UPDATE
- **S3:** Minor risks undocumented → BACKLOG

## Verification Commands

```bash
# Verify risk documents exist
for doc in RISK_REGISTER.md MITIGATIONS.md CONSTRAINTS.md; do
    [ -f "$doc" ] && echo "✅ $doc exists" || echo "❌ $doc missing"
done

# Check for high risks documented
grep -c "## High" RISK_REGISTER.md && echo "High risks documented"

# Verify stop conditions defined
grep -q "S0:" STOP_CONDITIONS.md && echo "✅ S0 conditions defined"
grep -q "S1:" STOP_CONDITIONS.md && echo "✅ S1 conditions defined"
```

## STATUS OUTPUT FORMAT

```
STATUS: done
FILES_MODIFIED:
  - RISK_REGISTER.md
  - MITIGATIONS.md
  - CONSTRAINTS.md
  - STOP_CONDITIONS.md
  - PROJECT_KB.md
COMMANDS_RUN:
  - opencode run --agent "facilitate risk brainstorm"
  - opencode run --agent "categorize risks"
  - opencode run --agent "identify technical risks"
  - opencode run --agent "document constraints"
  - opencode run --agent "define stop conditions"
TEST_RESULTS:
  - Risk coverage: COMPLETE
  - Mitigation coverage: 100% of high/critical
  - RL Score: 96
RL_SCORE: 96
NEXT_STEPS:
  - Proceed to Phase 1: Requirements
  - Monitor S0 risks weekly
```
