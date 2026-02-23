# Phase 1: Scope Governance

## Purpose

Establish clear boundaries, change control processes, and governance for what is IN vs OUT of scope.

## Prerequisites

- REQUIREMENTS.md from Phase 1a
- PRODUCT_THESIS.md
- CONSTRAINTS.md

## Step-by-Step

### Step 1: Scope Definition
```bash
opencode run --agent "define what's IN scope and OUT of scope for MVP, v1.0, and future versions" --file scope/scope-matrix.md
```

### Step 2: Change Control Process
```bash
opencode run --agent "document change request process: who can request, approval levels, impact analysis required" --file scope/change-control.md
```

### Step 3: MoSCoW Prioritization
```bash
opencode run --agent "categorize all requirements as Must-have, Should-have, Could-have, Won't-have" --file scope/moscow.md
```

## Status Output

```
STATUS: done
FILES_MODIFIED:
  - scope/scope-matrix.md
  - scope/change-control.md
  - scope/moscow.md
RL_SCORE: 95
NEXT_STEPS: Phase 1c API Contracts
```
