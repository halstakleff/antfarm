# Phase 4: AI Swarm Governance

## Purpose

Multi-agent coordination with clear handoffs.

## Step-by-Step

### Step 1: Orchestrator
```bash
opencode run --agent "agent orchestrator: spawn sub-agents, aggregate results" --file swarm/orchestrator.ts
```

### Step 2: Contracts
```bash
opencode run --agent "define handoff contracts: inputs/outputs per agent" --file swarm/contracts.ts
```

## Status Output

```
STATUS: done
FILES_MODIFIED:
  - swarm/
RL_SCORE: 95
NEXT_STEPS: Phase 4c Commits
```
