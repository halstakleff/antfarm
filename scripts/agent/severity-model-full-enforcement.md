# Severity Model: Full Enforcement

## Purpose

S0-S3 severity enforcement.

## Step-by-Step

### Step 1: Severity Detection
```bash
opencode run --agent "classify issues: S0, S1, S2, S3" --file severity/classifier.ts
```

### Step 2: Stop Conditions
```bash
opencode run --agent "enforce stops: S4 = release block" --file severity/stops.ts
```

## Status Output

```
STATUS: done
RL_SCORE: 95
```
