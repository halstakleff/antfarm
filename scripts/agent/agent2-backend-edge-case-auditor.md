# Agent 2: Backend Edge Case Auditor

## Purpose

Finds and tests edge cases in backend code.

## Step-by-Step

### Step 1: Edge Case Identification
```bash
opencode run --agent "analyze code for edge cases: null, undefined, limits" --file agents/auditor/edge-cases.md
```

### Step 2: Test Generation
```bash
opencode run --agent "generate tests for edge cases" --file agents/auditor/tests/
```

## AGENT HANDOFF

**INPUTS:** source_code
**OUTPUTS:** edge_case_report
**ARTIFACTS:** tests/edge/

## Status Output

```
STATUS: done
RL_SCORE: 96
```
