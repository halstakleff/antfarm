# Chaos Engineering Basics

## Purpose

Test resilience under failure.

## Step-by-Step

### Step 1: Failure Injection
```bash
opencode run --agent "inject failures: network, CPU, memory" --file chaos/inject.ts
```

### Step 2: Recovery Test
```bash
opencode run --agent "test recovery: auto-healing" --file chaos/recovery.ts
```

## Status Output

```
STATUS: done
RL_SCORE: 95
```
