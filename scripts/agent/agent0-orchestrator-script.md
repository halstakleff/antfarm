# Agent 0: Orchestrator

## Purpose

Master coordinator for multi-agent workflows.

## Step-by-Step

### Step 1: Task Routing
```bash
opencode run --agent "route tasks to appropriate agents: architect, developer, etc." --file agents/orchestrator/router.ts
```

### Step 2: Results Aggregation
```bash
opencode run --agent "aggregate agent outputs: merge, dedupe" --file agents/orchestrator/aggregator.ts
```

## AGENT HANDOFF CONTRACT

**INPUTS REQUIRED:**
- task_description
- agent_capabilities

**OUTPUTS PRODUCED:**
- agent_assignments
- execution_plan

**ARTIFACTS UPDATED:**
- PROJECT_KB.md
- orchestration_log.md

**FAILURE MODES:**
- Agent unavailable: retry with backup
- Task misunderstood: escalation to human

**STOP CONDITIONS:**
- RL score < 90 for 3 iterations

## Status Output

```
STATUS: done
RL_SCORE: 95
```
