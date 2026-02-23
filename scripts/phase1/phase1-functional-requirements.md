# Phase 1: Functional Requirements

## Purpose

Transform the product thesis into detailed, testable functional requirements. Defines what the system MUST do.

## When to Run

- After Phase 0 completion
- Before any architectural decisions
- When scoping releases

## Prerequisites

- PRODUCT_THESIS.md
- INVARIANTS.md
- Stakeholder availability

## Inputs

```yaml
user_personas: [from Phase 0]
success_metrics: [measurable criteria]
business_rules: [must-implement logic]
integration_points: [external systems]
```

## Outputs

```
STATUS: done
REQUIREMENTS_SPEC: /path/to/REQUIREMENTS.md
USER_STORIES: [backlog items]
ACCEPTANCE_CRITERIA: [per story]
RL_SCORE: [0-100]
```

## Step-by-Step Execution

### Step 1: User Story Mapping

```bash
opencode run --agent "decompose product thesis into user stories using format: As a [persona], I want [feature], so that [benefit]" --file requirements/user-stories.md

opencode run --agent "organize stories into epics and themes, map dependencies" --file requirements/story-map.md
```

### Step 2: Acceptance Criteria Definition

```bash
opencode run --agent "for each user story, define given-when-then acceptance criteria" --file requirements/acceptance-criteria.md

opencode run --agent "ensure criteria are: specific, measurable, achievable, relevant, time-bound (SMART)" --file requirements/acceptance-criteria.md
```

### Step 3: Business Rules Extraction

```bash
opencode run --agent "extract business rules: calculations, validations, workflows, state transitions" --file requirements/business-rules.md
```

## Ralph Loop

```bash
ITERATION=0; MAX_ITERS=5; THRESHOLD=95

while [ $ITERATION -lt $MAX_ITERS ]; do
    ITERATION=$((ITERATION + 1))
    
    STORIES=$(grep -c "## User Story" requirements/user-stories.md 2>/dev/null || echo "0")
    CRITERIA=$(grep -c "### Acceptance Criteria" requirements/acceptance-criteria.md 2>/dev/null || echo "0")
    
    RL_SCORE=$(( (STORIES * 30 + CRITERIA * 70) / 10 ))
    [ $RL_SCORE -gt 100 ] && RL_SCORE=100
    
    if [ $RL_SCORE -ge $THRESHOLD ]; then
        echo "STATUS: done"; echo "RL_SCORE: $RL_SCORE" >> PROJECT_KB.md
        exit 0
    fi
    
    echo "Refining requirements..."
done
```

## RL Scoring

| Criteria | Weight |
|----------|--------|
| Coverage | 30% |
| Testability | 25% |
| Clarity | 20% |
| Measurability | 15% |
| Priority | 10% |

## Status Output

```
STATUS: done
FILES_MODIFIED:
  - requirements/user-stories.md
  - requirements/acceptance-criteria.md
  - requirements/business-rules.md
RL_SCORE: 96
NEXT_STEPS: Phase 1b - Scope Governance
```
