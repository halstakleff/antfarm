# Swarm 3: Merge and Deduplication

## Purpose

Merge sub-agent outputs, remove duplicates.

## Step-by-Step

### Step 1: Collect Outputs
```bash
opencode run --agent "gather outputs from all sub-agents" --file swarm/merge/collect.ts
```

### Step 2: Deduplicate
```bash
opencode run --agent "remove duplicates: hash-based dedupe" --file swarm/merge/dedupe.ts
```

## Status Output

```
STATUS: done
RL_SCORE: 95
```
