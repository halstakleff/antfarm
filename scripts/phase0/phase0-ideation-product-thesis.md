# Phase 0: Ideation & Product Thesis

## Purpose

Establish the foundational understanding of WHAT we're building, WHY it matters, WHO it's for, and HOW we'll know it's successful. This script creates the product thesis document that guides all subsequent work.

## When to Run

- At the very beginning of any project
- When pivoting or reconsidering project direction
- When onboarding new stakeholders
- Before any architectural decisions

## Prerequisites

- Stakeholder availability for interviews
- Access to market research or user data
- Understanding of business constraints
- OpenCode CLI installed and configured

## Inputs

```yaml
stakeholders: [list of key people to interview]
business_constraints: [budget, timeline, regulatory requirements]
market_context: [competitive landscape, user needs]
technical_constraints: [existing systems, must-use tech]
success_metrics: [how will we measure success]
```

## Outputs

```
STATUS: done
PRODUCT_THESIS: /path/to/PRODUCT_THESIS.md
TARGET_USERS: [defined personas]
SUCCESS_METRICS: [measurable criteria]
KEY_CONSTRAINTS: [invariant boundaries]
RL_SCORE: [0-100]
```

## Step-by-Step Execution

### Step 1: Stakeholder Interviews

```bash
# Use OpenCode CLI to draft interview questions
opencode run --agent "draft stakeholder interview questions for [project name]" --file interviews/questions.md

# For each stakeholder
opencode run --agent "generate interview summary for [stakeholder name]" --file interviews/[name]-summary.md
```

### Step 2: Market & Competitive Analysis

```bash
# Research competitors
opencode run --agent "analyze competitors: [list], extract key differentiators" --file research/competitive-analysis.md

# Define market positioning
opencode run --agent "create positioning statement based on competitive analysis" --file research/positioning.md
```

### Step 3: User Persona Development

```bash
# Draft user personas
opencode run --agent "create 3-5 user personas with goals, pain points, and behaviors" --file docs/user-personas.md

# Validate personas with stakeholders
opencode run --agent "review user personas with stakeholder feedback" --file docs/user-personas-v2.md
```

### Step 4: Success Metrics Definition

```bash
# Define OKRs/KPIs
opencode run --agent "define success metrics: adoption, engagement, revenue, technical OKRs" --file docs/success-metrics.md

# Create measurement plan
opencode run --agent "draft measurement plan with data sources and tracking" --file docs/measurement-plan.md
```

### Step 5: Product Thesis Synthesis

```bash
# Generate final product thesis
opencode run --file PRODUCT_THESIS.md --agent "Synthesize into cohesive product thesis document covering: problem statement, solution hypothesis, target users, success metrics, key constraints, risks, and assumptions"
```

### Step 6: Sacred Document Updates

```bash
# Update PROJECT_KB.md
echo "## Phase 0 Complete: Product Thesis
- Thesis: [summary]
- Key Risks: [list]
- Success Metrics: [list]
- RL Score: [score]" >> PROJECT_KB.md

# Update any discovered patterns
opencode run --agent "add patterns to PROJECT_KB.md: [discovered patterns]" --file PROJECT_KEB.md
```

## Ralph Loop Wrapper

```bash
#!/bin/bash
ITERATION=0
MAX_ITERATIONS=5
RL_THRESHOLD=95

while [ $ITERATION -lt $MAX_ITERATIONS ]; do
    ITERATION=$((ITERATION + 1))
    echo "=== Ralph Iteration $ITERATION ==="
    
    # Execute phase 0 steps
    ./execute-phase0.sh
    
    # Calculate RL score based on criteria
    COMPLETENESS=$(grep -c "## " PRODUCT_THESIS.md 2>/dev/null || echo "0")
    STAKEHOLDER_COVERAGE=$(ls interviews/ | wc -l)
    METRICS_DEFINED=$(grep -c "### Success Metrics" PRODUCT_THESIS.md 2>/dev/null || echo "0")
    
    # Calculate weighted score
    RL_SCORE=$(( (COMPLETENESS * 30 + STAKEHOLDER_COVERAGE * 25 + METRICS_DEFINED * 45) / 100 ))
    
    echo "RL_SCORE: $RL_SCORE"
    
    if [ $RL_SCORE -ge $RL_THRESHOLD ]; then
        echo "✅ RL Threshold met"
        echo "STATUS: done" >> PROJECT_KB.md
        echo "RL_SCORE: $RL_SCORE" >> PROJECT_KB.md
        exit 0
    fi
    
    # Identify gaps and retry
    echo "🔁 Gaps identified, looping..."
    sleep 1
done

echo "❌ Max iterations reached"
echo "STATUS: failed" >> PROJECT_KB.md
exit 1
```

## Microsoft RL Scoring Rubric

| Criteria | Weight | Calculation |
|----------|--------|-------------|
| **Stakeholder Coverage** | 30% | ≥80% of key stakeholders interviewed |
| **Problem Clarity** | 25% | Problem statement clear and validated |
| **Success Metrics** | 25% | Measurable, time-bound OKRs defined |
| **Constraint Definition** | 15% | Technical/business boundaries explicit |
| **Risk Identification** | 5% | Top risks documented with mitigations |

**Thresholds:**
- 80-89: Iterate on gaps
- 90-94: PR-ready, minor polish
- **95-100: Release-ready (required)**

## Severity Enforcement Rules

- **S0:** No clear problem statement → STOP
- **S0:** Zero success metrics defined → STOP
- **S1:** Missing stakeholder input from critical parties → FIX
- **S1:** Unvalidated assumptions treated as facts → FIX
- **S2:** Incomplete competitive analysis → SCHEDULE

## Sacred Documents to Update

| Document | Section to Update |
|----------|-------------------|
| PRODUCT_THESIS.md | Full document creation |
| PROJECT_KB.md | Phase 0 completion entry |
| ARCHITECTURE.md | Constraints section (if technical constraints discovered) |
| RL_SCORES.md | Scoring history for Phase 0 |

## Verification Commands

```bash
# Verify PRODUCT_THESIS.md exists and has content
[ -f PRODUCT_THESIS.md ] && [ $(wc -l < PRODUCT_THESIS.md) -gt 50 ] && echo "✅ PRODUCT_THESIS.md valid"

# Check for required sections
grep -q "## Problem Statement" PRODUCT_THESIS.md && echo "✅ Problem section"
grep -q "## Solution Hypothesis" PRODUCT_THESIS.md && echo "✅ Solution section"
grep -q "## Success Metrics" PRODUCT_THESIS.md && echo "✅ Metrics section"

# Validate interviews directory
[ -d interviews/ ] && [ $(ls interviews/ | wc -l) -ge 3 ] && echo "✅ Sufficient stakeholder input"
```

## Rollback / Undo

```bash
# Revert to previous thesis version
git checkout HEAD~1 -- PRODUCT_THESIS.md

# Or restore from backup
cp PRODUCT_THESIS.md.backup PRODUCT_THESIS.md

# Clear iteration state
rm -f ralph-iteration-*
```

## Error Handling

| Failure | Remediation |
|---------|-------------|
| Stakeholder unavailable | Async questionnaire, proxy interviews |
| Conflicting requirements | Facilitate alignment meeting, document trade-offs |
| Unclear success metrics | Research industry benchmarks, set milestone metrics |
| Incomplete competitive analysis | Scope reduction, focus on top 3 competitors |

## STATUS OUTPUT FORMAT

```
STATUS: done
FILES_MODIFIED:
  - PRODUCT_THESIS.md
  - PROJECT_KB.md
  - interviews/questions.md
  - docs/user-personas.md
  - docs/success-metrics.md
COMMANDS_RUN:
  - opencode run --agent "draft stakeholder interview questions"
  - opencode run --agent "analyze competitors"
  - opencode run --agent "create user personas"
  - opencode run --agent "define success metrics"
  - opencode run --agent "synthesize product thesis"
TEST_RESULTS:
  - PRODUCT_THESIS.md: VALID (required sections present)
  - Interviews: 5 stakeholders covered
  - RL Score: 97
RL_SCORE: 97
NEXT_STEPS:
  - Proceed to Phase 1: Requirements & Contracts
  - Review ARCHITECTURE.md constraints section
```
